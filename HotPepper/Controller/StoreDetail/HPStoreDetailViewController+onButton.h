//
//  HPStoreDetailViewController+onButton.h
//  HotPepper
//
//

#import "HPStoreDetailViewController.h"
#import "HPBookmarkManager.h"

/*!
 @class Store information detail screen Category related to button processing of ViewController
 @abstract
 */
@interface HPStoreDetailViewController (onButton)

/*!
 @abstract  Bookmark add button correspondence processing
 @param     sender Instance of the selected button
 */
- (IBAction)onButtonAddBookmark:(id)sender;

/*!
 @abstract  Bookmark delete button correspondence processing
 @param     sender Instance of the selected button
 */
- (IBAction)onButtonDeleteFromBookmark:(id)sender;

@end
