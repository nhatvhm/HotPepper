//
//  HPSpecialEntity.h
//  HotPepper
//
//

#import "HHFetcherBase.h"
#import "HPSpecialEntity.h"

/*!
 @class Featured fetcher
 @abstract Feature collection XML is acquired from the server and held in the internal array
 */
@interface HPSpecialFetcher : HHFetcherBase

/*!
 @abstract  Acquire feature information from the network (whole)
 @param     successTask Tasks to be executed on the ViewController side when the special information acquisition processing is completed normally
            errorTask  Tasks to be executed on ViewController side when Feature information acquisition processing fails
 */
- (void) beginFetchWithSuccessTask:(void (^)())successTask
                         errorTask:(void (^)(NSError*))errorTask;

/*!
 @abstract  Return special feature information corresponding to the specified index from the managed feature information
 @param     idx Index value of feature information to be acquired
 @return    Feature information corresponding to the specified index value
 */
- (HPSpecialEntity *)specialEntityAtIndex:(NSInteger)idx;


/*!
 @abstract  Returns the total number of feature information managed
 */
- (NSInteger)numberOfSpecial;

@end
