//
//  HPThumbnailProxyView.h
//  HotPepper
//
//

#import <UIKit/UIKit.h>

@interface HPThumbnailProxyView : UIView

/*!
 @abstract  URL of image to be downloaded
 */
@property (nonatomic, strong) NSString *imageURL;



/*!
 @abstract  UIImage corresponding to the downloaded image
 */
- (UIImage*)image;


@end
