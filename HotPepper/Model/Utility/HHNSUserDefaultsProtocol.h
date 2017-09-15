//
//  HHNSUserDefaultsProtocol.h
//  HotPepper
//
//  Created by Hiền Hoà Co.,LTD on 8/25/17.
//  Copyright © 2017 Hiền Hoà Co.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef HHNSUserDefaultsProtocol_h
#define HHNSUserDefaultsProtocol_h



/*!
 * @protocol HHNSUserDefaultsProtocol
 * @abstract It is a protocol when handling inheriting NSUserDefaults prescribed in the iOS development standard.
 */
@protocol HHNSUserDefaultsProtocol <NSObject>

@required

/*!
 * @abstract ユーザー初期値（デフォルト値）を返す
 */
- (NSDictionary *)defaults;

/*!
 * @abstract Set initial value
 */
- (void) registerDefaults;

@optional

/*!
 * @abstract Restore user setting value to initial value
 */
- (void) rollbackDefaults;

@end


#endif /* HHNSUserDefaultsProtocol_h */
