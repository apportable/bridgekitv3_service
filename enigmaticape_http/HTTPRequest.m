#import "HTTPRequest.h"
#import "HTTPMessage.h"

@implementation HTTPRequest
    
@synthesize headers = _headers;
@synthesize method  = _method;
@synthesize url     = _url;
@synthesize body    = _body;


- ( id ) initWithHTTPMessage:( HTTPMessage * ) http_message {

    if( (self = [super init]) ) {
        
        CFHTTPMessageRef request = [http_message request];
        
        _headers = (NSDictionary *)CFBridgingRelease(CFHTTPMessageCopyAllHeaderFields( request ));
        _url     = (NSURL        *)CFBridgingRelease(CFHTTPMessageCopyRequestURL( request ));
        _method  = (NSString     *)CFBridgingRelease(CFHTTPMessageCopyRequestMethod( request ));
        _body    = (NSData       *)CFBridgingRelease(CFHTTPMessageCopyBody( request ));
    }
    
    return self;
}

- (NSString*) getBodyAsText {
    return [[NSString alloc] initWithData:_body
                                  encoding:NSUTF8StringEncoding];
}// Hmm, that rather assumes UTF8, doesn't it ?


/*
   De-URLEncode an HTTP POST body
   NB that this really doesn't belong here, but is supplied for
   the purposes of demonstration, because there are quite enough
   classes to be going on with.
 */
-( NSDictionary *) urlDecodePostBody {
    

    
    NSMutableDictionary * kvPairs = [[NSMutableDictionary alloc]init];
    
    /* First, translate "+" to " ", then split by &
       using quite a fugly bit of code, sorry.
     */
    NSArray * queryComponents
    = [ [[self getBodyAsText] stringByReplacingOccurrencesOfString:@"+"
                                             withString:@" " ]
         componentsSeparatedByString:@"&"
       ];
    
    
    /*
     We replaced '+' signs above because application/x-www-form-urlencoded
     data (as in the POST body) encodes spaces as '+'
     instead of %20%. Handy, eh ?
     */
    for (NSString * kvPairString in queryComponents) {
        
        NSArray   * keyValuePair = [kvPairString componentsSeparatedByString:@"="];
        
        if( [keyValuePair count] != 2 ) { continue; }
        
        /*
         Similarly, we avoid using the NSString methods here
         because they don't encode or decode properly. Grr!
         */
        NSString * decoded_key
            = (NSString*)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(
                                                                
                    NULL,
                    (CFStringRef)[keyValuePair objectAtIndex:0],
                    CFSTR("")
                ));
        
        
        NSString * decoded_value
            = (NSString*)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(
                                                                    
                    NULL,
                    (CFStringRef)[keyValuePair objectAtIndex:1],
                    CFSTR("")
                ));
        
        
        [kvPairs setValue: decoded_value forKey: decoded_key ];
    }
    
    return kvPairs;
}

-( void ) dealloc {

}

@end
