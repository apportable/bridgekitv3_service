//
//  bkserviceActivity.m
//  bkservice
//
//  Created by Nick Richards on 9/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <BridgeKitV3/AndroidIntent.h>
#import <BridgeKitV3/AndroidActivity.h>
#import <BridgeKitV3/JavaClass.h>

#import "bkserviceActivity.h"

@implementation bkserviceActivity

@bridge (callback) run = run;

- (void)run
{
	// Launch the service at application launch
    JavaClass *serviceClass = [JavaClass forName:@"com.apportable.bkservice.bkserviceService"];
    AndroidIntent *intent = [[AndroidIntent alloc] initWithContext:self class:serviceClass];
    [self startService:intent];
}

@end
