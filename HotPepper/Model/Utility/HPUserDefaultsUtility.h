//
//  HPUserDefaultsUtilit.h
//  HotPepper
//
//  Created by Hiền Hoà Co.,LTD on 8/25/17.
//  Copyright © 2017 Hiền Hoà Co.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHNSUserDefaultsProtocol.h"

extern const NSInteger HPUserDefaultValueNumFetches;

/*!
 @class Wrapper class for using NSUserDefaults
 @abstract  Implement the HHNSUserDefaultsProtocol specified in the development platform
 */
@interface HPUserDefaultsUtility : NSObject <HHNSUserDefaultsProtocol>

/*!
 @abstract  HHNSUserDefaultsProtocol Returns a pointer to an instance of the implementation class
 @return    Pointer to the HHNSUserDefaultsProtocol class instance which is unique within the application
 */
+ (id)sharedInstance;


/*!
 @abstract  Returns user initial value (default value)
 @return    Default user settings in the application. It can be said to be "initial value" of user setting.
 */
- (NSDictionary *)defaults;


/*!
 @abstract      Set the initial value.
 @discussion    Specifically, using the above defaults method
 Using the Apple Foundation class's registerDefaults method etc. Register the default value of SUserDefaults.
 */
- (void)registerDefaults;


/*!
 @abstract  Restore user setting value to initial value
 */
- (void)rollbackDefaults;


/*!
 @abstract      Set the number of results obtained
 @param         flag TRUE: 50 cases, FALSE: 20 cases
 */
- (void)setFlagNumFetches:(BOOL)flag;


/*!
 @abstract  Flag mobile coupons.
 @param     flag YES -> Only show mobile coupons
 */
- (void)setFlagMobileCoupon:(BOOL)flag;


/*!
 @abstract  Set "only during business" flag.
 @param     flag YES -> only during business
 */
- (void)setFlagOpenStoreNow:(BOOL)flag;


/*!
 @abstract  Returns the number of results obtained currently in the application.
 @return   Results Number of acquisitions by number.
 */
- (NSInteger)numFetches;


/*!
 @abstract  Returns "mobile coupon flag" currently set for application
 */
- (BOOL)useMobileCoupon;


/*!
 @abstract  Returns "flag that only appears during business" currently set for application
 */
- (BOOL)openStoreNow;

@end
