//
//  HPBookmarkTopViewController.m
//  HotPepper
//
//

#import "HPBookmarkTopViewController.h"

#import "HPBookmarkManager.h"
#import "HPThumbnailProxyView.h"
#import "HPBookmarkStoreCell.h"
#import "HPStoreDetailViewController.h"
#import "HPPropertyListUtility.h"


const NSInteger kBookmarkProxyImageViewTag = 888;

@interface HPBookmarkTopViewController (){
    NSMutableArray *_thumbnailProxyViewArray;
}

@end

@implementation HPBookmarkTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[HPBookmarkManager sharedInstance] numberOfBookmark];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"bookmarkStoreCell";
    HPBookmarkStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //
    [[cell.contentView viewWithTag:kBookmarkProxyImageViewTag] removeFromSuperview];
    
    //
    if([_thumbnailProxyViewArray count] > 0) {
        HPThumbnailProxyView *proxyImage = [_thumbnailProxyViewArray objectAtIndex:indexPath.row];
        proxyImage.tag = kBookmarkProxyImageViewTag;
        [cell.contentView addSubview: proxyImage];
    }
    
    //
    if([[HPBookmarkManager sharedInstance] numberOfBookmark]) {
        cell.bookmarkStoreNameLabel.text = [[HPBookmarkManager sharedInstance] bookmarkAtIndex:indexPath.row].name;
    }else{
        cell.bookmarkStoreNameLabel.text = @"";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //
    if ([[segue identifier] isEqualToString:@"bookmarkStoreSegue"]) {
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        HPBookmarkedStoreEntity *bookmark = [[HPBookmarkManager sharedInstance] bookmarkAtIndex:selectedIndexPath.row];
        
        HPStoreDetailViewController *vc = (HPStoreDetailViewController*)[segue destinationViewController];
        
        //
        HPStoreEntity *store = [[HPStoreEntity alloc] init];
        store.storeId = bookmark.storeId;
        store.name = bookmark.name;
        store.imageURL = bookmark.logoImageURL;
        store.nameKana = bookmark.nameKana;
        store.address = bookmark.address;
        
        //
        vc.currentBookmarkStoreId = bookmark.storeId;
        vc.storeEntity = store;
        
        if([_thumbnailProxyViewArray count] > 0) {
            vc.thumbnailImage = (UIImage *)[[_thumbnailProxyViewArray objectAtIndex:selectedIndexPath.row] image];
        }
    }
}


@end
