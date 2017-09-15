//
//  SDSNotifierDefaultHandler.h
//  SDSNotifier
//
//  Created by tkoshida on 12/06/19.
//  Copyright 2012年 RECRUIT CO,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDSNotifier.h"

// API Response Keys
#define kAPIKeyVersionUpCd  @"versionup_cd"
#define kAPIKeyAppVersion   @"app_version"
#define kAPIKeyVersionUpMessage    @"versionup_message"

// User Defaults Key
#define kSDSNotifierUserDefaultsAppVersion  @"SDSNotifierUserDefaultsAppVersion"


@interface SDSNotifierDefaultHandler : NSObject <SDSNotifierDelegate, UIAlertViewDelegate> {
    NSDictionary *_target;
    NSString *_updateURL;
}

@property (nonatomic, copy) NSString *updateURL;

// use below as protected methods
- (NSDate *)_dateWithIso8601String:(NSString *)string;
- (NSDictionary *)_chooseTargetWithUpdates:(NSArray *)updates;
- (void)_notifyNormalUpdate:(NSDictionary *)target;
- (void)_notifyForceUpdate:(NSDictionary *)target;
- (void)_notifySuspend:(NSDictionary *)target;
- (void)_notifyCustomizedA:(NSDictionary *)target;
- (void)_notifyCustomizedB:(NSDictionary *)target;
- (void)_notifyCustomizedC:(NSDictionary *)target;
- (void)_notifyUpdate:(NSDictionary *)target;
- (void)_handleUpdates:(NSArray *)updates;
- (void)_handleNotifications:(NSArray *)notifications;
- (void)_actNormalUpdateAlertWithButtonIndex:(NSInteger)buttonIndex;
- (void)_actForceUpdateAlertWithButtonIndex:(NSInteger)buttonIndex;
- (void)_actSuspendAlertWithButtonIndex:(NSInteger)buttonIndex;
- (void)_actCustomizedAAlertWithButtonIndex:(NSInteger)buttonIndex;
- (void)_actCustomizedBAlertWithButtonIndex:(NSInteger)buttonIndex;
- (void)_actCustomizedCAlertWithButtonIndex:(NSInteger)buttonIndex;


@end
