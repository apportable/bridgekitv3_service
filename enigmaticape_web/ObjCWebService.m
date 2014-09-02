#import <Foundation/Foundation.h>
#import "HttpService.h"
#import "HTTPRequest.h"
#import "HTTPResponse.h"
#import "ObjCWebService.h"

@implementation WebService {
    HttpService * _service;
}

- ( HTTPResponse * ) GET:( HTTPRequest * ) request {

    HTTPResponse * response = [[HTTPResponse alloc]initWithResponseCode:200];
    
    [response setBodyText:[NSString stringWithFormat:@"GET %@",[request.url path]]];
    
    return response;
}

- ( HTTPResponse * ) POST:( HTTPRequest * ) request {
    
    HTTPResponse * response = [[HTTPResponse alloc]initWithResponseCode:200];
    
    [response setBodyText:[NSString stringWithFormat:@"POST %@",[request.url path]]];
    
    return response;
}

- ( void ) startWebService
{
    _service = [[HttpService alloc] init];
    _service.responder = self;
    [_service startServiceOnPort:4000];

}

@end
