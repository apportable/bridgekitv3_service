//
//  bkserviceService.h
//  bkservice
//
//  Created by Nick Richards on 9/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <BridgeKitV3/BridgeKit.h>
#import "ObjCWebService.h"

BRIDGE_CLASS("com.apportable.bkservice.bkserviceService")
@interface bkserviceService : AndroidService

@property (strong, nonatomic) WebService* webService;

- (void)run;

@end
