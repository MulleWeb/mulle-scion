//
//  main.m
//  MulleScion
//
//  Created by Nat! on 24.02.13.
//
//  Copyright (c) 2013 Nat! - Mulle kybernetiK
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  Neither the name of Mulle kybernetiK nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//
#import "import-private.h"

#import "MulleScionObjectModel+WebServer.h"
#import "WebServer.h"
#import <MulleObjC/NSDebug.h>

#include <sys/param.h>  // for MAXPATHLEN
#include <unistd.h>

// all C strings
#ifndef DEBUG
# define DOCUMENT_ROOT INSTALL_PREFIX "/share/mulle-scion/dox"
#else
# define DOCUMENT_ROOT "dox"
#endif
#define SERVER_HOST "127.0.0.1"
#define SERVER_PORT "18048"

static NSString  *processName( void);


static void   fail( char *format, ...)
{
   va_list   va;

   if( format)
   {
      va_start( va, format);
      {
         mulle_fprintf( stderr, "error: ");
         mulle_vfprintf( stderr, format, va);
         mulle_fprintf( stderr, "\n\n");
      }
      va_end( va);
   }

   mulle_fprintf( stderr, "Usage:\n"
                          "   %s [options] <input> [datasource] [output] [arguments]\n"
                          "\n"
                          "   The Objective-C Template processor\n"
                         "   See: https://github.com/mulle-kybernetik/MulleScion\n",
                        [processName() cString]);
   mulle_fprintf( stderr,
"\n"
"Options:\n"
"   -v[vv]   : increase verbosity\n"
"   -I       : set ':' style search path for {%% includes ... %%} statements\n"
"   -w       : start webserver for " DOCUMENT_ROOT "\n"
"   -z       : write compressed archive to outputfile\n"
"   -Z       : write compressed keyed archive to outputfile (for IOS)\n"
"\n"
"Input:\n"
"   -        : Read template from stdin\n"
"   template : a MulleScion template path or URL\n"
"\n"
"Datasource:\n"
"   -        : Read data from stdin (only if input is not stdin already)\n"
"   args     : use arguments as datasource (see below)\n"
"   bundle   : a NSBundle. Its NSPrincipalClass will be the datasource\n"
"   plist    : plist files or URLs separated by ':' merged into a datasource\n"
"   none     : empty datasource\n"
"\n"
"Output:\n"
"   -        : Write result to stdout\n"
"   file     : Write result to file\n"
"\n"
"Arguments:\n"
"   key=value: key/value pairs to be used as __ARGV__ contents\n"
"              (unless args as datasource was specified)\n"
"\n"
"Examples:\n"
"   echo '***{{ VALUE }}***' | mulle-scion - args - VALUE=\"VfL Bochum 1848\"\n"
"   echo '***{{ __ARGV__[ 0]}}***' | mulle-scion - none - \"VfL Bochum 1848\"\n"
   );

   exit( 1);
}

static inline void   usage( void)
{
   fail( NULL);
}



static NSFileHandle  *outputStreamWithInfo( NSDictionary *info);
static NSDictionary  *getInfoFromArguments( NSArray *arguments);
static id            acquirePropertyListOrDataSourceFromBundle( NSString *s);


static NSString  *processName( void)
{
   NSArray        *arguments;
   NSEnumerator   *rover;

   arguments = [[NSProcessInfo processInfo] arguments];
   rover     = [arguments objectEnumerator];
   return( [[rover nextObject] lastPathComponent]);
}


@interface NSFileHandle( MulleScionOutput) < MulleScionOutput >
@end


@implementation NSFileHandle( MulleScionOutput)

- (void) appendString:(NSString *) s
{
   NSData   *data;

   data = [s dataUsingEncoding:NSUTF8StringEncoding];
   [self writeData:data];
}

@end



/* #####
   ##### #####  CODE SPECIFIC FOR MULLE SCION
   ##### */

static NSDictionary  *localVariablesFromInfo( NSDictionary *info)
{
   NSMutableDictionary   *sanitize;

   sanitize = [NSMutableDictionary dictionary];
   [sanitize setObject:[info objectForKey:@"MulleScionRootTemplate"]
                forKey:@"MulleScionRootTemplate"];
   [sanitize setObject:[info objectForKey:@"MulleScionPropertyListName"]
                forKey:@"MulleScionPropertyListName"];
   [sanitize setObject:[info objectForKey:@"__ARGV__"]
                forKey:@"__ARGV__"];

   return( sanitize);
}


static MulleScionTemplate   *acquireTemplateFromPath( NSString *fileName,
                                                      NSArray *searchPath)
{
   MulleScionTemplate   *template;
   NSString             *string;
   NSData               *data;
   NSURL                *url;

   template = nil;
   //
   // if fileName stars with '{' assume, that it's a command line template
   //
   if( [fileName hasPrefix:@"{"]) //  on her milk white neck ... the devil's mark
      template = [[[MulleScionTemplate alloc] initWithString:fileName
                                                  searchPath:searchPath] autorelease];
   else
      if( [fileName isEqualToString:@"-"])
      {
         data   = [[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile];
         string = [[[NSString alloc] initWithData:data
                                         encoding:NSUTF8StringEncoding] autorelease];
         template = [[[MulleScionTemplate alloc] initWithString:string
                                                     searchPath:searchPath] autorelease];

      }
      else
      {
         if( [fileName rangeOfString:@"://"].length)
         {
            url      = [NSURL URLWithString:fileName];
            template = [[[MulleScionTemplate alloc] initWithContentsOfFile:url
                                                                searchPath:searchPath] autorelease];
         }
         else
            template = [[[MulleScionTemplate alloc] initWithFile:fileName
                                                      searchPath:searchPath] autorelease];
      }

   if( ! template)
      NSLog( @"Template \"%@\" could not be read", fileName);

   return( template);
}


/*       #####
   ##### #####
         ##### */
static id   acquireDataSourceFromBundle( NSString *s)
{
   NSBundle   *bundle;
   id         plist;
   Class      cls;

   bundle = [NSBundle bundleWithPath:s];
   cls    = [bundle principalClass];
   if( ! cls)
   {
      NSLog( @"bundle \"%@\" load failure", s);
      return( nil);
   }

   if( ! [cls respondsToSelector:@selector( mulleScionDataSource)])
   {
      NSLog( @"bundle's principal class \"%@\" does not respond to +mulleScionDataSource", cls);
      return( nil);
   }

   plist = [cls performSelector:@selector( mulleScionDataSource)];
   if( ! plist)
   {
      NSLog( @"bundle's principal class \"%@\" returned nil for +mulleScionDataSource", cls);
      return( nil);
   }

   if( ! [plist respondsToSelector:@selector( valueForKeyPath:)])
   {
      NSLog( @"bundle's dataSource\"%@\" does not respond to -valueForKeyPath:", [plist class]);
      return( nil);
   }
   return( plist);
}


static id   acquirePropertyListFromArgs( NSArray *args)
{
   NSMutableDictionary   *plist;
   NSEnumerator          *rover;
   NSString              *arg;
   id                    components;
   NSString              *key;
   NSString              *value;

   plist = [NSMutableDictionary dictionary];

   rover = [args objectEnumerator];
   while( arg = [rover nextObject])
   {
      components = [arg componentsSeparatedByString:@"="];

      key = [components objectAtIndex:0];
      if( ! [key length])
         continue;

      switch( [components count])
      {
      default :
         components = [[components mutableCopy] autorelease];
         [components removeObjectAtIndex:0];
         value = [components componentsJoinedByString:@"="];
         break;

      case 2 :
         value = [components objectAtIndex:1];
         break;

      case 1 :
         value = @"1";
         break;
      }

      // quote stuff will have been removed by shell
      [plist setObject:value
                forKey:key];
   }
   return( plist);
}


static id   acquirePropertyListOrDataSourceFromBundle( NSString *s)
{
   NSData     *data;
   NSString   *error;
   NSURL      *url;
   id         plist;
   NSString   *extension;

   if( [s isEqualToString:@"none"])
      return( [NSDictionary dictionary]);

   if( [s isEqualToString:@"-"])
      data = [[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile];
   else
   {
      extension = [s pathExtension];

      if( ! [extension isEqualToString:@"plist"] &&
          ! [extension isEqualToString:@"json"] &&
          ! [extension isEqualToString:@"xml"])
      {
          return (acquireDataSourceFromBundle(s));
      }

      if( [s rangeOfString:@"://"].length)
      {
         url  = [NSURL URLWithString:s];
         data = [NSData dataWithContentsOfURL:url];
      }
      else
         data = [NSData dataWithContentsOfFile:s];
   }

   error = nil;
   plist = [NSPropertyListSerialization propertyListFromData:data
                                            mutabilityOption:NSPropertyListImmutable
                                                      format:NULL
                                            errorDescription:&error];
   if( ! plist)
   {
      NSLog( @"property list failure for \"%@\": %@", s, error);
      exit( 1);
   }

   return( plist);
}


static NSDictionary  *getInfoFromEnumerator( NSEnumerator *rover)
{
   NSArray               *argv;
   NSMutableDictionary   *info;
   NSString              *outputName;
   NSString              *plistName;
   NSString              *nextName;
   NSString              *plistPath;
   NSString              *templateName;
   NSString              *name;
   id                    plist;
   NSMutableDictionary   *combinedPlist;
   NSArray               *components;
   NSUInteger            i, n;
   NSCharacterSet        *punctuation;

   info         = [NSMutableDictionary dictionary];
   templateName = [rover nextObject];
   plistPath    = [rover nextObject];
   outputName   = [rover nextObject];
   argv         = [rover allObjects];

   if( ! [templateName length])
      fail( "template is empty");
   if( ! [plistPath length])
      plistPath = @"none";
   if( ! [outputName length])
      outputName = @"-";

   components    = [NSMutableArray arrayWithArray:[plistPath componentsSeparatedByString:@":"]];
   n             = [components count];
   combinedPlist = [components count] 
                   ? [NSMutableDictionary dictionary] 
                   : nil;

   punctuation = [NSCharacterSet punctuationCharacterSet]; // has . and /
   for( i = 0; i < n; i++)
   {
      plistName = [components objectAtIndex:i];
      if( i + 1 < n && ! [plistName rangeOfCharacterFromSet:punctuation].length)
      {
         // recombine URLs, if needed
         nextName = [components objectAtIndex:i + 1];
         if( [nextName hasPrefix:@"//"])
         {
            plistName = [NSString stringWithFormat:@"%@:%@", plistName, nextName];
            i++;
         }
      }

      if( [plistName isEqualToString:@"keyvalue"] || [plistName isEqualToString:@"args"])
      {
         plist = acquirePropertyListFromArgs( argv);
         argv  = [NSArray array];
      }
      else
         plist = acquirePropertyListOrDataSourceFromBundle( plistName);
      if( ! plist)
         fail( "could not acquire plist %s", [plistName UTF8String]);

      // so if the read plist is an array, we can't really merge it
      // so we turn it into a separate entry, indexed by the name of 
      // the plist: sans extension.  
      if( combinedPlist)
      {
         if( ! [plist isKindOfClass:[NSDictionary class]])
         {
            name  = [plistName stringByDeletingPathExtension];
            plist = [NSDictionary dictionaryWithObject:plist
                                                forKey:name];
         }
         [combinedPlist addEntriesFromDictionary:plist];
      }
   }

   [info setObject:combinedPlist ? combinedPlist : plist
            forKey:@"dataSource"];

   [info setObject:templateName
            forKey:@"MulleScionRootTemplate"];
   [info setObject:plistPath
            forKey:@"MulleScionPropertyListName"];
   [info setObject:outputName
            forKey:@"output"];
   if( argv)
      [info setObject:argv
               forKey:@"__ARGV__"];

   return( info);
}


static NSDictionary  *getInfoFromArguments( NSArray *arguments)
{
   return( getInfoFromEnumerator( [arguments objectEnumerator]));
}


static NSFileHandle   *outputStreamWithInfo( NSDictionary *info)
{
   NSString       *outputName;
   NSFileHandle   *stream;

   outputName = [info objectForKey:@"output"];
   stream     = [NSFileHandle mulleOutputFileHandleWithFilename:outputName];
   if( ! stream)
      NSLog( @"failed to create output file \"%@\"", outputName);
   return( stream);
}


static void  loadBundles( NSEnumerator *rover)
{
   NSBundle   *bundle;
   NSString   *argument;

   while( argument = [rover nextObject])
   {
      if( [argument hasPrefix:@"-"])
         continue;

      bundle = [NSBundle bundleWithIdentifier:argument];
      if( ! bundle)
         bundle = [NSBundle bundleWithPath:argument];

#ifdef __MULLE_OBJC__
      if( ! [bundle loadBundle])
#else
      if( ! [bundle load])
#endif
      {
         NSLog( @"Couldn't load bundle %@", argument);
         exit( 1);
      }
   }
}


static int   _archive_main( NSArray *arguments, NSArray *searchPath, BOOL keyed)
{
   MulleScionTemplate   *template;
   NSDictionary         *info;
   NSString             *archiveName;

   info  = getInfoFromArguments( arguments);
   if( ! info)
      return( -3);

   archiveName = [info objectForKey:@"output"];
   if( [archiveName isEqualToString:@"-"])
      return( -3);

   template = acquireTemplateFromPath( archiveName, searchPath);

   if( ! template)
      return( -1);

   if( ! [template writeArchive:archiveName
                          keyed:keyed ? YES : NO])
   {
      NSLog( @"Archive \"%@\" could not be written", archiveName);
      return( -1);
   }

   return( 0);
}



/*
 *
 */
#ifndef DONT_HAVE_WEBSERVER

static char    *default_options[] =
{
   "document_root", DOCUMENT_ROOT,
   "listening_ports", SERVER_HOST ":" SERVER_PORT,
   "num_threads", "1",
   "index_files", "index.scion,index.html,index.htm,index.cgi,index.shtml,index.php,index.lp",
   NULL
};


static int   main_www( NSArray *arguments, NSArray *searchPath)
{
   id            plist;
   char          *s;
   NSString      *path;
   NSString      *root;
   char          buf[ MAXPATHLEN + 1];
   NSEnumerator  *rover;

   rover = [arguments objectEnumerator];
   root  = [rover nextObject];

   if( ! root)
   {
      s = getenv( "MulleScionServerRoot");
      if( ! s)
      {
         s = DOCUMENT_ROOT;
         if( s[ 0] != '/')
         {
            if( getcwd( buf, MAXPATHLEN + 1))
            {
               if( strlen( buf) + strlen( s) + 2 <= MAXPATHLEN)
               {
                  strcat( buf, "/");
                  strcat( buf, s);
                  s = buf;
               }
            }
         }
      }
      root = [NSString stringWithCString:s];
   }

   default_options[ 1] = [root UTF8String];

   s = getenv( "MulleScionServerPort");
   if( s)
      default_options[ 3] = s;

   path = [root stringByAppendingPathComponent:@"properties.plist"];
   s    = getenv( "MulleScionServerPlist");
   if( s)
      path = [NSString stringWithCString:s];

   plist = acquirePropertyListOrDataSourceFromBundle( path);
   if( ! plist)
      plist = [NSDictionary dictionary];

   loadBundles( rover);

#if __APPLE__
   system( "(sleep 1 ; open http://" SERVER_HOST ":" SERVER_PORT ") &");
#endif
   [WebServer runServerWithCStringOptions:default_options
                             documentRoot:root
                               dataSource:plist];
   return( 0);
}
#endif


static int   _main( NSArray *arguments, NSArray *searchPath)
{
   NSDictionary         *info;
   NSFileHandle         *stream;
   MulleScionTemplate   *template;

   info = getInfoFromArguments( arguments);
   if( ! info)
      return( -3);   //

   template = acquireTemplateFromPath( [info objectForKey:@"MulleScionRootTemplate"],
                                       searchPath);
   if( ! template)
      return( -1);

   stream = outputStreamWithInfo( info);
   if( ! stream)
      return( -2);

   [template writeToOutput:stream
                dataSource:[info objectForKey:@"dataSource"]
            localVariables:localVariablesFromInfo( info)];
   return( 0);
}


int main( int argc, char *argv[])
{
   NSAutoreleasePool   *pool;
   int                 rval;
   int                 i;
   int                 j;
   int                 webserver;
   int                 verbosity;
   int                 compressed;
   NSMutableArray      *searchPath;
   NSMutableArray      *arguments;
   NSProcessInfo       *processInfo;
   NSString            *s;

#if defined( __MULLE_OBJC__) && defined( DEBUG)
   if( mulle_objc_global_check_universe( __MULLE_OBJC_UNIVERSENAME__) !=
         mulle_objc_universe_is_ok)
   {
      MulleObjCHTMLDumpUniverseToTmp();
      MulleObjCDotdumpUniverseToTmp();
      return( 111);
   }
#endif

   webserver  = 0;
   verbosity  = 0;
   compressed = -1;
   searchPath = nil;

   for( i = 1; i < argc && argv[ i][ 0] == '-'; i++)
   {
      j = 1; // passed '-'
      if( argv[ i][ j] == '-')
      {
         ++j; // passed '--'

         if( ! strcmp( &argv[ i][ j], "version"))
         {
            printf( "%s\n", MulleScionFrameworkVersion);
            return( 0);
         }
         if( ! strcmp( &argv[ i][ j], "help"))
            usage();
         fail( "unknown option %s", argv[ i]);
      }

      switch( argv[ i][ j])
      {
      case 'h' :
         usage();

      case '\0' : // '-'
         goto done;

      default :
         fail( "unknown option %s", argv[ i]);

      case 'v' :
         verbosity = 1;
         ++j;
         if( argv[ i][ j] == 'v')
         {
            verbosity++;
            ++j;
            if( argv[ i][ j] == 'v')
            {
               verbosity++;
               ++j;
            }
         }
         break;

      case 'w' :
         ++j;
         webserver = 1;
         break;

      case 'z' :
         ++j;
         compressed = 0;
         break;

      case 'Z' :
         ++j;
         compressed = 1;
         break;

      case 'I' :
         ++j;
         if( argv[ i][ j])
            fail( "unknown option %s", argv[ i]);
         if( ++i >= argc)
            fail( "missing colon separated path after -I");

         searchPath = searchPath ? searchPath : [NSMutableArray array];
         s          = [NSString stringWithUTF8String:argv[ i]];
         [searchPath addObjectsFromArray:[s componentsSeparatedByString:@":"]];
         continue;
      }
      // no trailing garbage ? like
      if( ! argv[ i][ j])
         continue;     
      fail( "unknown option %s", argv[ i]);
   }

done:
   arguments = [NSMutableArray array];
   while( i < argc)
   {
      s = [NSString stringWithUTF8String:argv[ i]];
      [arguments addObject:s];
      i++;
   }

   if( verbosity)
   {
      processInfo = [NSProcessInfo processInfo];
      [processInfo mulleSetEnvironmentValue:@"YES"
                                     forKey:@"MULLESCION_DUMP_FILE_INCLUDES"];
      if( verbosity > 1)
      {
         [processInfo mulleSetEnvironmentValue:@"YES"
                                        forKey:@"MULLESCION_DUMP_COMMANDS"];
         [processInfo mulleSetEnvironmentValue:@"YES"
                                        forKey:@"MULLESCION_DUMP_EXPRESSIONS"];
         if( verbosity > 2)
         {
            [processInfo mulleSetEnvironmentValue:@"YES"
                                           forKey:@"MULLESCION_DUMP_MACROS"];
         }
      }
   }
   
#ifndef DONT_HAVE_WEBSERVER
   if( webserver)
      return( main_www( arguments, searchPath));
#endif

   if( compressed >= 0)
      return( _archive_main( arguments, searchPath, compressed));

   pool = [NSAutoreleasePool new];
NS_DURING
   rval = _main( arguments, searchPath);
NS_HANDLER
   NSLog( @"%@", localException);
   rval = -4;
NS_ENDHANDLER
#if defined( DEBUG) || defined( PROFILE)
   [pool release];
#endif
# ifdef PROFILE
   // sleeping for the sampler to hit stuff
   sleep( 2);
# endif
   return( rval);
}

