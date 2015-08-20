//
//  MulleScion.m
//  MulleScion
//
//  Created by Nat! on 25.02.13.
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


#import "MulleScion.h"
#import "MulleScionTemplate+CompressedArchive.h"

#ifndef PROJECT_VERSION
# error "specify project version on command line -DPROJECT_VERSION=1848.x"
#endif

#define _STRINGIFY(x) #x
#define STRINGIFY(x) _STRINGIFY( x)


char  MulleScionFrameworkVersion[] = STRINGIFY( PROJECT_VERSION);


@implementation MulleScionTemplate ( Convenience)

+ (BOOL) writeToOutput:(id <MulleScionOutput>) output
          templateFile:(NSObject <MulleScionStringOrURL> *) fileName
            dataSource:(id <MulleScionDataSource>) dataSource
        localVariables:(NSDictionary *) locals
{
   MulleScionTemplate   *template;
   
   template = [[[MulleScionTemplate alloc] initWithContentsOfFile:fileName] autorelease];
   if( ! template)
      return( NO);
   
   [template writeToOutput:output
                dataSource:dataSource
            localVariables:locals];
   
   return( YES);
}


+ (NSString *) descriptionWithTemplateFile:(NSObject <MulleScionStringOrURL> *) fileName
                                dataSource:(id <MulleScionDataSource>) dataSource
                            localVariables:(NSDictionary *) locals
{
   MulleScionTemplate   *template;
   
   template = [[[MulleScionTemplate alloc] initWithContentsOfFile:fileName] autorelease];
   if( ! template)
      return( nil);
   return( [template descriptionWithDataSource:dataSource
                                localVariables:locals]);
}


+ (NSString *) descriptionWithTemplateFile:(NSObject <MulleScionStringOrURL> *) fileName
                                dataSource:(id <MulleScionDataSource>) dataSource
{
   return( [self descriptionWithTemplateFile:fileName
                                  dataSource:dataSource
                              localVariables:nil]);
}


static id   acquirePropertyList( NSObject <MulleScionStringOrURL> *s)
{
   NSData    *data;
   NSString  *error;
   id        plist;
   
   if( [s isKindOfClass:[NSURL class]])
      data  = [NSData dataWithContentsOfURL:(NSURL *) s];
   else
      data  = [NSData dataWithContentsOfFile:(NSString *) s];
   
   if( ! data)
   {
      NSLog( @"failed to open: %@", s);
      return( data);
   }
   
   error = nil;
   plist = [NSPropertyListSerialization propertyListFromData:data
                                            mutabilityOption:NSPropertyListImmutable
                                                      format:NULL
                                            errorDescription:&error];
   if( ! plist)
      NSLog( @"property list failure: %@", error);
   return( plist);
}


+ (NSString *) descriptionWithTemplateFile:(NSObject <MulleScionStringOrURL> *) fileName
                          propertyListFile:(NSObject <MulleScionStringOrURL> *) plistFileName
                            localVariables:(NSDictionary *) locals
{
   MulleScionTemplate   *template;
   id                    plist;
   
   template = [[[MulleScionTemplate alloc] initWithContentsOfFile:fileName] autorelease];
   if( ! template)
      return( nil);

   plist = acquirePropertyList( plistFileName);
   if( ! plist)
      return( nil);
   return( [template descriptionWithDataSource:plist
                                localVariables:locals]);
}



+ (NSString *) descriptionWithTemplateFile:(NSObject <MulleScionStringOrURL> *) fileName
                          propertyListFile:(NSObject <MulleScionStringOrURL> *) plistFileName
{
   return( [self descriptionWithTemplateFile:fileName
                            propertyListFile:plistFileName
                              localVariables:nil]);
}


- (id) _initWithContentsOfFile:(NSString *) fileName
{
   MulleScionParser   *parser;
#ifndef DONT_HAVE_MULLE_SCION_CACHING
   
   BOOL               isCaching;
   NSString           *cachePath;
   
   isCaching = [MulleGetClass( self) isCacheEnabled];
   
   cachePath = [self cachePathForPath:fileName];
   if( cachePath)
   {
      self = [self initWithContentsOfArchive:cachePath];
      if( self)
         return( self);
   }
   else
#endif
   {
      [self autorelease];
      // self = nil;
   }
   
   parser = [MulleScionParser parserWithContentsOfFile:fileName];
   self   = [[parser template] retain];
   
#ifndef DONT_HAVE_MULLE_SCION_CACHING
   if( isCaching)
   {
      if( ! [self writeArchive:cachePath])
      {
         NSLog( @"Cache write to %@ failed, caching turned off", cachePath);
         [MulleGetClass( self) setCacheEnabled:NO];
      }
   }
#endif
   return( self);
}


- (id) _initWithContentsOfURL:(NSURL *) url
{
   MulleScionParser   *parser;
#ifndef DONT_HAVE_MULLE_SCION_CACHING
   
   BOOL               isCaching;
   NSString           *cachePath;
   
   isCaching = [MulleGetClass( self) isCacheEnabled];
   
   cachePath = [self cachePathForPath:[url path]];
   if( cachePath)
   {
      self = [self initWithContentsOfArchive:cachePath];
      if( self)
         return( self);
   }
   else
#endif
   {
      [self autorelease];
      // self = nil;
   }
   
   parser = [MulleScionParser parserWithContentsOfURL:url];
   self   = [[parser template] retain];
   
#ifndef DONT_HAVE_MULLE_SCION_CACHING
   if( isCaching)
   {
      if( ! [self writeArchive:cachePath])
      {
         NSLog( @"Cache write to %@ failed, caching turned off", cachePath);
         [MulleGetClass( self) setCacheEnabled:NO];
      }
   }
#endif
   return( self);
}


- (id) initWithContentsOfFile:(NSObject <MulleScionStringOrURL> *) fileName
{
   if( [fileName isKindOfClass:[NSURL class]])
      return( [self _initWithContentsOfURL:(NSURL *) fileName]);
   return( [self _initWithContentsOfFile:(NSString *) fileName]);
}


- (id) initWithFile:(NSString *) fileName
{
   if( [MulleScionTemplate isArchivedTemplatePath:fileName])
      self = [self initWithContentsOfArchive:fileName];
   else
      self = [self _initWithContentsOfFile:fileName];
   
   return( self);
}

             
static MulleScionPrinter  *createPrinterWithDatasource( id dataSource)
{
   //   if( ! dataSource)
   // dataSource = [NSDictionary dictionary];
   return( [[[MulleScionPrinter alloc] initWithDataSource:dataSource] autorelease]);
}


- (NSString *) descriptionWithDataSource:(id) dataSource
                          localVariables:(NSDictionary *) locals
{
   MulleScionPrinter   *printer;
   NSAutoreleasePool   *pool;
   NSString            *s;
   
   pool = [NSAutoreleasePool new];

   printer = createPrinterWithDatasource( dataSource);
   [printer setDefaultlocalVariables:locals];
   s = [printer describeWithTemplate:self];
   
   [s retain];
   [pool release];
   return( [s autorelease]);
}


- (void) writeToOutput:(id <MulleScionOutput>) output
            dataSource:(id <MulleScionDataSource>) dataSource
        localVariables:(NSDictionary *) locals
{
   MulleScionPrinter   *printer;
   NSAutoreleasePool   *pool;
   
   pool = [NSAutoreleasePool new];
   printer = createPrinterWithDatasource( dataSource);
   [printer setDefaultlocalVariables:locals];
   [printer writeToOutput:output
                 template:self];
   [pool release];
}

@end


#ifndef DONT_HAVE_MULLE_SCION_CACHING

#define MulleScionCacheDirectoryKey   @"MulleScionCacheDirectory"

@implementation MulleScionTemplate ( Caching)

static BOOL       cacheEnabled_;
static NSString   *cacheDirectory_;


static BOOL  checkCacheDirectory( NSString *path)
{
   NSFileManager      *manager;

   manager = [NSFileManager defaultManager];
   if( ! [manager createDirectoryAtPath:path
            withIntermediateDirectories:YES
                             attributes:nil
                                  error:NULL])
   {
      NSLog( @"can't create cache directory %@", path);
      return( NO);;
   }
   if( ! [manager isWritableFileAtPath:path])
   {
      NSLog( @"can't write to cache directory %@", path);
      return( NO);;
   }
   return( YES);
}


+ (void) load
{
   NSAutoreleasePool  *pool;
#ifndef PROFILE
   NSString           *s;
#endif
   
   pool = [NSAutoreleasePool new];
#ifndef PROFILE
   s = [[NSUserDefaults standardUserDefaults] stringForKey:MulleScionCacheDirectoryKey];
   if( ! s)
      s = [[[NSProcessInfo processInfo] environment] objectForKey:MulleScionCacheDirectoryKey];
   if( s)
      if( checkCacheDirectory( s))
      {
         [self setCacheDirectory:s];
         [self setCacheEnabled:YES];
      }
#endif
   [pool release];
}


//
// bug: can't deal with templates of same name in different subdirectories
// should hash the path and use that as a cache-filename
//
- (NSString *) cachePathForPath:(NSString *) fileName
{
   BOOL               isCaching;
   NSString           *cacheDir;
   NSString           *cachePath;
   NSString           *name;
   
   isCaching = [MulleGetClass( self) isCacheEnabled];
   if( ! isCaching)
      return( nil);
   
   name      = [[fileName lastPathComponent] stringByDeletingPathExtension];
   cacheDir  = [MulleGetClass( self) cacheDirectory];
   if( ! cacheDir)
      cacheDir = [fileName stringByDeletingLastPathComponent];
   
   if( ! [cacheDir length])
      cacheDir = @".";
   cachePath = [cacheDir stringByAppendingPathComponent:name];
   cachePath = [cachePath stringByAppendingPathExtension:@"scionz"];
   
   return( cachePath);
}


+ (void) setCacheDirectory:(NSString *) directory
{
   [cacheDirectory_ autorelease];
   cacheDirectory_ = [directory copy];
}


+ (NSString *) cacheDirectory
{
   return( cacheDirectory_);
}


+ (void) setCacheEnabled:(BOOL) flag;
{
   cacheEnabled_ = flag;
}


+ (BOOL) isCacheEnabled
{
   return( cacheEnabled_);
}

@end

#endif

