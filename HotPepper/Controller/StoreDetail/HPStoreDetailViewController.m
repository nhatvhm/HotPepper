//
//  HPStoreDetailViewController.m
//  HotPepper
//
//

#import "HPStoreDetailViewController.h"
#import "HPBookmarkManager.h"

@interface HPStoreDetailViewController ()

@end

@implementation HPStoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    _storeNameLabel.text = _storeEntity.name;
    _storeAddressLabel.text = _storeEntity.address;
    
    if(_thumbnailImage) {
        _storeImageView.image = _thumbnailImage;
    }
    
    if(_storeEntity.kDetaiCoupon != 0) {
        _storeCouponLabel.hidden = TRUE;
    }
    
    //
    if (_storeEntity) {
        
        HPBookmarkManager *man = [HPBookmarkManager sharedInstance];
        HPBookmarkedStoreEntity *bookmark = [man searchBookmark: _storeEntity.storeId];
        if(bookmark) {
            self.currentBookmarkStoreId = bookmark.storeId;
        }
    }
    
    //
    [self updateButtonState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (!(self.isViewLoaded && self.view.window)) {
        
    }
}


- (void)viewDidUnload {
    [self setStoreImageView:nil];
    [self setStoreNameLabel:nil];
    [self setStoreAddressLabel:nil];
    [self setStoreCouponLabel:nil];
    [self setAddBookmarkButton:nil];
    [self setDeleteBookmarkButton:nil];
    [super viewDidUnload];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) updateButtonState {
    
    //
    if (_currentBookmarkStoreId) {
        self.addBookmarkButton.hidden = YES;
        self.deleteBookmarkButton.hidden = NO;
    } else {
        self.addBookmarkButton.hidden = NO;
        self.deleteBookmarkButton.hidden = YES;
    }
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    //
    if ([self.currentBookmarkStoreId length] > 0) {
        
        HPBookmarkManager *man = [HPBookmarkManager sharedInstance];
        HPBookmarkedStoreEntity *bookmark = [man searchBookmark:self.currentBookmarkStoreId];
        
        //
        if (!bookmark) {
            //
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

@end
