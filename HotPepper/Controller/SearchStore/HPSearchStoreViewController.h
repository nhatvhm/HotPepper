//
//  HPSearchStoreViewController.h
//  HotPepper
//
//

#import <UIKit/UIKit.h>

@interface HPSearchStoreViewController : UITableViewController
/*!
 @abstract  When displaying the store list linked to the area, the area code
 */
@property (nonatomic, strong) NSString *areaCode;

/*!
 @abstract  When displaying the store list linked to the feature, that special feature code
 */
@property (nonatomic, strong) NSString *specialCode;


@end
