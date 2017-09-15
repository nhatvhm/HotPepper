//
//  HPAreaFetcher.h
//  HotPepper
//
//

#import "HHFetcherBase.h"
#import "HPAreaEntity.h"

/*!
 @class Area information fetcher
 @abstract Download XML of area information from the network and keep it in a buffer managed by itself.
 */
@interface HPAreaFetcher : HHFetcherBase

/*!
 @abstract  Area information acquisition (whole)
 @param     successTask Tasks to be executed on ViewController side when area information acquisition processing is completed normally
            errorTask  Tasks to be executed on ViewController side when area information acquisition processing fails
 */
- (void) beginFetchWithSuccessTask:(void (^)())successTask
                         errorTask:(void (^)(NSError*))errorTask;


/*!
 @abstract  Area information acquisition (individual)
 @param     idx Index of area information to be acquired
 @return    Area information corresponding to the specified index
 */
- (HPAreaEntity *) areaEntityAtIndex:(NSInteger)idx;


/*!
 @abstract  Return the total number of area information managed
 */
- (NSInteger) numberOfArea;


@end
