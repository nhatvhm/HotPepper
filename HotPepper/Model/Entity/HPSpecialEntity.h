//
//  HPSpecialEntity.h
//  HotPepper
//
//

#import <Foundation/Foundation.h>


/*!
 @class Feature · entity
 @abstract Retain information corresponding to each line of feature list screen
 */
@interface HPSpecialEntity : NSObject

/*!
 @abstract  Special feature code
 */
@property (nonatomic, strong) NSString *code;

/*!
 @abstract  Special feature name
 */
@property (nonatomic, strong) NSString *name;

@end
