//
//  WebServer.m
//  mulle-scion
//
//  Created by Nat! on 02.03.13.
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

#ifndef DONT_HAVE_WEBSERVER

#import "WebServer.h"

#import "MulleScionObjectModel+WebServer.h"

#import "import-private.h"

#include <signal.h>
#include <stdlib.h>
#include <unistd.h>


@implementation WebServer

#pragma mark - Response

- (MulleCivetWebResponse *) webResponseForWebRequest:(MulleCivetWebRequest *) request
{
   NSURL                        *url;
   NSString                     *query;
   NSDictionary                 *queryDictionary;
   MulleScionTemplate           *template;
   MulleCivetWebTextResponse    *response;
   NSData                       *utf8Data;
   NSString                     *s;

   url  = [request URL];
   NSLog( @"%@", url);

   /* 404 */
   if( ! url)
      return( [super webResponseForWebRequest:request]);

   s = [url path];
   if( [s hasPrefix:@"/"])
      s = [s substringFromIndex:1];
   if( ! [s length])
      s = @"index.scion";

   queryDictionary = [url mulleQueryDictionary];
   template        = [[[MulleScionTemplate alloc] initWithContentsOfFile:s
                                                                 options:queryDictionary] autorelease];
   if( ! template)
      return( [super webResponseForWebRequest:request]);

   s = [template descriptionWithDataSource:[self dataSource]
                            localVariables:nil];

   response = [MulleCivetWebTextResponse webResponseForWebRequest:request];
   [response setHeaderValue:@"text/html"
                     forKey:MulleHTTPContentTypeKey];
   [response appendString:s];

   return( response);
}



#pragma mark - Setup

static int     global_exit_flag;


static void   signal_handler( int sig_num)
{
   global_exit_flag = sig_num;
}


+ (void) runServerWithCStringOptions:(char **) options
                          dataSource:(id) plist
{
   WebServer   *server;
   NSString    *dir;
   char        **p;

   /* Setup signal handler: quit on Ctrl-C */
   signal( SIGTERM, signal_handler);
   signal( SIGINT, signal_handler);

   for( p = options; *p; p++)
   {
      if( strcmp( *p, "document_root"))
         continue;

      if( *++p)
      {
         dir = [NSString stringWithCString:*p];
         if( [dir hasSuffix:@".scion"])
            dir = [dir stringByDeletingLastPathComponent];
         [[NSFileManager defaultManager] changeCurrentDirectoryPath:dir];
      }
      break;
   }

   server = [[[self alloc] initWithCStringOptions:options] autorelease];
   if( ! server)
   {
      NSLog( @"Failed to start mulle-scion web server.");
      return;
   }
   [server setDataSource:plist];

   NSLog( @"%s started on port(s) %s with document root \"%s\"",
       server->_server_name,
       [server optionCStringForKeyCString:"listening_ports"],
       [server optionCStringForKeyCString:"document_root"]);

   while( global_exit_flag == 0)
      sleep( 1);

   NSLog( @"Exiting on signal %d, waiting for all threads to finish...",
          global_exit_flag);
   [server mullePerformFinalize];

   NSLog( @"%s", " done.\n");
}

@end

#endif
