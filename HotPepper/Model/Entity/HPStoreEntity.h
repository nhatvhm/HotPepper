//
//  HPStoreEntity.h
//  HotPepper
//
//

#import <Foundation/Foundation.h>


/*!
 @class Store · Entity
 @abstract Retain information corresponding to each row on the store list screen
 */
@interface HPStoreEntity : NSObject

/*!
 @abstract  store code
 */
@property (nonatomic, strong) NSString *storeId;


/*!
 @abstract  store name
 */
@property (nonatomic, strong) NSString *name;


/*!
 @abstract  Store thumbnail image URL
 */
@property (nonatomic, strong) NSString *imageURL;


/*!
 @abstract  Is it a store?
 */
@property (nonatomic, strong) NSString *nameKana;


/*!
 @abstract  store address
 */
@property (nonatomic, strong) NSString *address;


/*!
 @abstract  mobile coupon presence / absence flag
 */
@property NSInteger kDetaiCoupon;


@end
