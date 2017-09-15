//
//  HPBookmarkedStoreEntity+CoreDataProperties.h
//  HotPepper
//
//

#import "HPBookmarkedStoreEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HPBookmarkedStoreEntity (CoreDataProperties)

+ (NSFetchRequest<HPBookmarkedStoreEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSDate *created;
@property (nonatomic) NSInteger kDetaiCoupon;
@property (nullable, nonatomic, copy) NSString *logoImageURL;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *nameKana;
@property (nullable, nonatomic, copy) NSString *storeId;

@end

NS_ASSUME_NONNULL_END
