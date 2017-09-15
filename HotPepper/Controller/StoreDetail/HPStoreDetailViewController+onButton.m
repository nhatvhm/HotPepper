//
//  HPStoreDetailViewController+onButton.m
//  HotPepper
//
//

#import "HPStoreDetailViewController+onButton.h"

@implementation HPStoreDetailViewController (onButton)

- (IBAction)onButtonAddBookmark:(id)sender {
    
    HPBookmarkManager *man = [HPBookmarkManager sharedInstance];
    
    //
    HPBookmarkedStoreEntity *newBookmark = [man addBookmark:self.storeEntity];
    self.currentBookmarkStoreId = newBookmark.storeId;
    
    //
    [self updateButtonState];
    
}

- (IBAction)onButtonDeleteFromBookmark:(id)sender {
    
    //
    if ([self.currentBookmarkStoreId length] > 0) {
        
        HPBookmarkManager *man = [HPBookmarkManager sharedInstance];
        HPBookmarkedStoreEntity *bookmark = [man searchBookmark:self.currentBookmarkStoreId];
        
        //
        if (bookmark) {
            [man deleteBookmark:bookmark];
            self.currentBookmarkStoreId = @"";
        }
    }
    
    //
    [self updateButtonState];
    
    //
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
