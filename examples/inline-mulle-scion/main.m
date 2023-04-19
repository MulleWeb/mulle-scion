#import <Foundation/Foundation.h>
#import <MulleScion/MulleScion.h>


static NSString  *templateContents = @"This is just a {{ stupid }} little test.\n";


int main(int argc, const char * argv[])
{
   NSMutableString     *output;
   NSAutoreleasePool   *pool;
   NSDictionary        *info;
   MulleScionParser    *parser;
   NSData              *data;
   MulleScionTemplate  *template;

   pool = [NSAutoreleasePool new];

   // create a compiled template
   data     = [templateContents dataUsingEncoding:NSUTF8StringEncoding];
   parser   = [[[MulleScionParser alloc] initWithData:data
                                             fileName:@"whatever"
                                           searchPath:nil] autorelease];
   template = [parser template];

   // use template to produce output
   output = [NSMutableString object];
   info   = [NSDictionary dictionaryWithObject:@"clever"
                                        forKey:@"stupid"];
   [template writeToOutput:output
                dataSource:info
            localVariables:nil];

   if( output)
      fputs( [output UTF8String], stdout);

   return( ! [output length]);
}

