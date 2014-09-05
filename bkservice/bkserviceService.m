//
//  bkserviceService.m
//  bkservice
//
//  Created by Nick Richards on 9/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "bkserviceService.h"

#import "ObjCWebService.h"

@implementation bkserviceService

@bridge (callback) run = run;

- (void)run
{
    self.webService = [[WebService alloc] init];
    [self.webService startWebService];
}

@end
