//
//  HPAreaEntity.h
//  HotPepper
//
//

#import <Foundation/Foundation.h>


/*!
 @class Area · entity
 @abstract Retain information corresponding to each row on the area list screen
 */
@interface HPAreaEntity : NSObject

/*!
 @abstract  Area code
 */
@property (nonatomic, strong) NSString *code;

/*!
 @abstract  Area name
 */
@property (nonatomic, strong) NSString *name;

@end
