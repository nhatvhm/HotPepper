//
//  HPStoreDetailViewController.h
//  HotPepper
//
//

#import <UIKit/UIKit.h>
#import "HPThumbnailProxyView.h"
#import "HPStoreEntity.h"

@interface HPStoreDetailViewController : UIViewController

/*!
 @abstract  Store information to display
 */
@property (strong, nonatomic) HPStoreEntity *storeEntity;


/*!
 @abstract  Thumbnail image of store UIImage (for receiving parameters)
 */
@property (weak, nonatomic) UIImage *thumbnailImage;


/*!
 @abstract  In the case of bookmarked shop information, the bookmark shop ID
 */
@property (strong, nonatomic) NSString *currentBookmarkStoreId;



/*!
 @abstract  UIImageView of the store thumbnail image to be displayed on the screen
 */
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;


/*!
 @abstract  Store name label
 */
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;


/*!
 @abstract  Store address label
 */
@property (weak, nonatomic) IBOutlet UILabel *storeAddressLabel;


/*!
 @abstract  With cell phone coupon No label label
 */
@property (weak, nonatomic) IBOutlet UILabel *storeCouponLabel;


/*!
 @abstract  Button to add to bookmark
 */
@property (weak, nonatomic) IBOutlet UIButton *addBookmarkButton;


/*!
 @abstract  Delete button from bookmark
 */
@property (weak, nonatomic) IBOutlet UIButton *deleteBookmarkButton;

/*!
 @abstract  Update button status display
 */
- (void) updateButtonState;



@end
