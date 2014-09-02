//
//  AppDelegate.h
//  bkapp
//
//  Created by Nick Richards on 9/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjCWebService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WebService* webService;

@end
