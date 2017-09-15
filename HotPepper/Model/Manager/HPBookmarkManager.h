//
//  PBookmarkManager.h
//  HotPepper
//
//

#import <Foundation/Foundation.h>

#import "HHManagerBase.h"
#import "HPStoreEntity.h"
#import "HPCoreDataUtility.h"
#import "HPBookmarkedStoreEntity+CoreDataClass.h"
#import "HPBookmarkedStoreEntity+CoreDataProperties.h"
#import "PrefixHeader.pch"

/*!
 @class Bookmark manager
 @abstract We manage user's bookmark information in CoreData.
 */
@interface HPBookmarkManager : HHManagerBase

/*!
 @abstract      Return pointer to bookmark manager · instance
 */
+ (id) sharedInstance;


/*!
 @abstract  Read bookmark data from managed CoreData storage
 @param     successTask Tasks to be executed when the reading process is normally completed
 rowTask: In the process of reading bookmark data from storage and managing it, tasks to be executed for each bookmark entity
 */
- (void) beginFetchWithSuccessTask:(void (^)())successTask
                           rowTask:(void (^)(HPBookmarkedStoreEntity*))task;

/*!
 @abstract  Bookmark addition processing
 @param     store Shop ID of the store that you want to bookmark
 @return    Pointer to Bookmark Flyerly Bookmark entity
 */
- (HPBookmarkedStoreEntity *)addBookmark:(HPStoreEntity *)store;


/*!
 @abstract  Return instances of the bookmark entity corresponding to the store ID
 @param     storeId Shop ID of the shop where you want to check if you are bookmarking
 @return    An instance of the bookmark entity corresponding to the specified store ID
 */
- (HPBookmarkedStoreEntity *)searchBookmark:(NSString *)storeId;


/*!
 @abstract  Returns the instance of the bookmark entity corresponding to the specified index value
 @param     idx Index value of the bookmark you want to obtain
 */
- (HPBookmarkedStoreEntity *)bookmarkAtIndex:(NSInteger)idx;


/*!
 @abstract  Deletes the specified bookmark entity from bookmark management
 @param     bookmark Instance of Bookmark Entity to delete
 */
- (void)deleteBookmark:(HPBookmarkedStoreEntity *)bookmark;


/*!
 @abstract  Delete all bookmarked store information
 */
- (NSInteger)deleteAllBookmark;


/*!
 @abstract  Returns the number of bookmarked stores
 @return    The number of bookmarkable stores is in integer type.
 */
- (NSInteger)numberOfBookmark;

@end
