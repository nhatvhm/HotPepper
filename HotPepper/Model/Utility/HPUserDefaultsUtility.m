//
//  HPUserDefaultsUtilit.m
//  HotPepper
//
//  Created by Hiền Hoà Co.,LTD on 8/25/17.
//  Copyright © 2017 Hiền Hoà Co.,LTD. All rights reserved.
//

#import "HPUserDefaultsUtility.h"

NSString *const kUserDefaultsNumFetches = @"userDefaultsNumFetches";
NSString *const kUserDefaultsMobileCoupon = @"userDefaultsMobileCoupon";
NSString *const kUserDefaultsStoreOpen = @"userDefaultsStoreOpen";


const NSInteger HPUserDefaultValueNumFetches = 20;
const NSInteger HPUserDefaultValueMobileCoupon = 0;
const NSInteger HPUserDefaultValueStoreOpen = 0;


@implementation HPUserDefaultsUtility


+ (id)sharedInstance {
    static id _HPUserDefaultsManagerSharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_HPUserDefaultsManagerSharedInstance == NULL) {
            _HPUserDefaultsManagerSharedInstance = [[self alloc] init];
        }
    });
    
    return(_HPUserDefaultsManagerSharedInstance);
}


- (id) init {
    if(self = [super init]) {
        [self registerDefaults];
    }
    
    return self;
}


#pragma mark - HHNSUserDefaultsProtocol Required Methods

- (NSDictionary *)defaults {
    NSMutableDictionary *defaultDic = [NSMutableDictionary dictionary];
    [defaultDic setObject:[NSNumber numberWithInt:HPUserDefaultValueNumFetches]
                   forKey:kUserDefaultsNumFetches];
    [defaultDic setObject:[NSNumber numberWithInt:HPUserDefaultValueMobileCoupon]
                   forKey:kUserDefaultsMobileCoupon];
    [defaultDic setObject:[NSNumber numberWithInt:HPUserDefaultValueStoreOpen]
                   forKey:kUserDefaultsStoreOpen];
    
    return defaultDic;
}

- (void)registerDefaults {
    [[NSUserDefaults standardUserDefaults] registerDefaults:[self defaults]];
}


#pragma mark - HHNSUserDefaultsProtocol Optional Methods

- (void)rollbackDefaults {
    [self setFlagNumFetches:NO];
    [self setFlagMobileCoupon:NO];
    [self setFlagOpenStoreNow:NO];
}


#pragma mark - Original method

- (void)setFlagNumFetches:(BOOL)flag {
    NSInteger value = HPUserDefaultValueNumFetches;
    if (flag) {
        value = 50;
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[NSNumber numberWithInteger:value] forKey:kUserDefaultsNumFetches];
    [ud synchronize];
}

- (void)setFlagMobileCoupon:(BOOL)flag {
    NSInteger value = HPUserDefaultValueMobileCoupon;
    if (flag) {
        value = 1;
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[NSNumber numberWithInteger:value] forKey:kUserDefaultsMobileCoupon];
    [ud synchronize];
}

- (void)setFlagOpenStoreNow:(BOOL)flag {
    NSInteger value = HPUserDefaultValueStoreOpen;
    if (flag) {
        value = 1;
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[NSNumber numberWithInteger:value] forKey:kUserDefaultsStoreOpen];
    [ud synchronize];
}

- (NSInteger)numFetches {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [[ud objectForKey:kUserDefaultsNumFetches] integerValue];
}

- (BOOL)useMobileCoupon {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:kUserDefaultsMobileCoupon] integerValue] > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)openStoreNow {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:kUserDefaultsStoreOpen] integerValue] > 0) {
        return YES;
    }
    return NO;
}


@end
