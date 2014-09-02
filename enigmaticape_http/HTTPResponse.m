#import "HTTPResponse.h"


@implementation HTTPResponse {
	CFHTTPMessageRef      _response;
}

- ( id ) initWithResponseCode:(int) response_code {
	
    if( (self = [super init]) ) {
        
		_response = CFHTTPMessageCreateResponse(
                                                
                        NULL,
                        response_code,
                        NULL,
                        kCFHTTPVersion1_1
                    );
	}
	
    return self;
}

- ( id ) init {

	if( (self = [super init]) ) {
        
		_response = CFHTTPMessageCreateResponse(
                                                
                        NULL,
                        200,
                        NULL,
                        kCFHTTPVersion1_1
                    );
	}
	
    return self;
}

- ( void ) setHeaderField:(NSString*) header_field toValue:(NSString*) header_value {
	
    CFHTTPMessageSetHeaderFieldValue(
        
        _response,
        (CFStringRef)CFBridgingRetain(header_field),
        (CFStringRef)CFBridgingRetain(header_value)
    );
    
}


- ( void ) setAllHeaders:(NSDictionary*) header_dict {
	
	for( NSString * key in [header_dict allKeys] ) {
		CFHTTPMessageSetHeaderFieldValue(

            _response,
		    (CFStringRef)CFBridgingRetain(key),
			(CFStringRef)CFBridgingRetain([header_dict valueForKey:key])
		);
	}
}

- ( void ) setBodyText:(NSString*) body_text {
	
    CFHTTPMessageSetHeaderFieldValue(
    
        _response,
        CFSTR("Content-Type"),
        CFSTR("text/html")
    );
	
    CFHTTPMessageSetBody(
                         
        _response,
        (CFDataRef)CFBridgingRetain([body_text dataUsingEncoding:NSUTF8StringEncoding])
    );

}

- ( void ) setBodyData:(NSData*) body_data {
		
    CFHTTPMessageSetBody( _response, (CFDataRef) CFBridgingRetain(body_data) );
}

- ( NSData * ) serialize {
	
    return (NSData*)
            CFBridgingRelease(CFHTTPMessageCopySerializedMessage( _response ));
}

- ( void ) dealloc {
    
    CFRelease( _response );
}
@end
