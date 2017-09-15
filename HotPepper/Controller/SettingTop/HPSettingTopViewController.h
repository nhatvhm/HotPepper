//
//  HPSettingTopViewController.h
//  HotPepper
//
//

#import <UIKit/UIKit.h>


/*!
 @class     Setting screen of ViewController
 */
@interface HPSettingTopViewController : UITableViewController<UIActionSheetDelegate>

/*!
 @abstract  Segment Ctrl to select the number of results to be obtained
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *settingResultNumSegment;


/*!
 @abstract  UI switch to switch the presence / absence of mobile coupon
 */
@property (weak, nonatomic) IBOutlet UISwitch *settingCouponSwitch;


/*!
 @abstract  UI switch to switch searching flags only during business hours
 */
@property (weak, nonatomic) IBOutlet UISwitch *settingHourSwitch;

@end
