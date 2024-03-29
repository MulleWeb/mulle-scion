//
//  Hoedown+MulleScionPrinting.m
//  MulleScion
//
//  Created by Nat! on 17.02.15.
//  Copyright (c) 2015 Mulle kybernetiK. All rights reserved.
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
#import "MulleMarkdown+MulleScionPrinting.h"


@implementation NSString( MulleScionPrinting)

- (NSString *) scionHoedownedString:(BOOL) escaping
{
   NSString     *s;
   NSUInteger   i, n;
   NSMutableString   *buf;
   NSArray      *components;

   components = [self componentsSeparatedByString:@"```"];  // 3 * '`'
   n = [components count];
   if( n <= 1)
      return( [self hoedownedString]);

   buf = [NSMutableString object];
   for( i = 1; i < n; i += 2)
   {
      s = [components objectAtIndex:i - 1];
      s = [s hoedownedString];  // normal
      [buf appendString:s];

      s = [components objectAtIndex:i];  // normal
      [buf appendString:@"<pre><code>"];
      if( [s hasPrefix:@"\n"])
         s = [s substringFromIndex:1];
      if( escaping)
         s = [s mulleStringByEscapingHTMLForASCII];
      [buf appendString:s];
      [buf appendString:@"</code></pre>"];
   }

   if( i == n)
   {
      s = [components objectAtIndex:n - 1];
      s = [s hoedownedString];  // normal
      [buf appendString:s];
   }
   return( buf);
}

@end


@implementation MulleMarkdown( MulleScionPrinting)

- (NSString *) flushWithLocalVariables:(NSMutableDictionary *) locals
                            dataSource:(id <MulleScionDataSource>) dataSource
{
   NSString   *s;

   s = [_buf scionHoedownedString:_htmlEscape];
   return( s);
}


- (id) evaluateValue:(id) value
      localVariables:(NSMutableDictionary *) locals
          dataSource:(id <MulleScionDataSource>) dataSource
{
   [self appendString:value];
   return( MulleScionNull);
}

@end
