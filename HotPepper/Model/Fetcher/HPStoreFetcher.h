//
//  HPStoreFetcher.h
//  HotPepper
//
//

#import "HHFetcherBase.h"
#import "HPStoreEntity.h"

/*!
 @class     Store fetcher
 @abstract  Obtain and manage shops/store from the network
 */
@interface HPStoreFetcher : HHFetcherBase

/*!
 @abstract  Acquisition of store information (whole)
 @param     typeNumber NSNumber for determining whether to acquire store information linked to the area or to acquire area information associated with the feature
 code: Area code or special code
 successTask: Tasks to be executed on the ViewController side when the acquisition process is completed normally
 rowTask: In the process of reading shop information from the network and making it management object, tasks to be executed for each store information entity
 errorTask: A task to be executed on the ViewController side when the acquisition process fails
 */
- (void) beginFetchWithTypeNumber:(NSNumber*)typeNumber
                        codeValue:(NSString*)code
                      successTask:(void (^)())successTask
                          rowTask:(void (^)(HPStoreEntity*))task
                        errorTask:(void (^)(NSError*))errorTask;

/*!
 @abstract  Acquiring store information (individual)
 @param     idx Index value of store information to be acquired
 @return    Store information corresponding to the designated index value
 */
- (HPStoreEntity *)storeEntityAtIndex:(NSInteger)idx;


/*!
 @abstract  Total number of shop/store information managed by fetcher
 */
- (NSInteger)numberOfStore;

@end
