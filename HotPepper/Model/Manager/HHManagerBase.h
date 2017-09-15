//
//  HHManagerBase.h
//  HotPepper
//
//

#import <Foundation/Foundation.h>

/*!
 @class     Base class of manager class (abstract class)
 @abstract  When raising a manager class, it inherits from this class and raises it.
 */
@interface HHManagerBase : NSObject

/*!
 @abstract      Instance get method
 @discussion    Override this method in the derived class.
 This method is equivalent to the timing of initializing the instance variables.
 */
+ (HHManagerBase*)sharedInstance;

@end
