//
//  HPBookmarkedStoreEntity+CoreDataProperties.m
//  HotPepper
//
//

#import "HPBookmarkedStoreEntity+CoreDataProperties.h"

@implementation HPBookmarkedStoreEntity (CoreDataProperties)

+ (NSFetchRequest<HPBookmarkedStoreEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HPBookmarkedStoreEntity"];
}

@dynamic address;
@dynamic created;
@dynamic kDetaiCoupon;
@dynamic logoImageURL;
@dynamic name;
@dynamic nameKana;
@dynamic storeId;

@end
