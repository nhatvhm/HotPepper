//
//  HPSearchStoreViewController.m
//  HotPepper
//
//

#import "HPSearchStoreViewController.h"

#import "HPStoreFetcher.h"
#import "HPPropertyListUtility.h"
#import "HPThumbnailProxyView.h"
#import "HPSearchStoreCell.h"
#import "HPStoreDetailViewController.h"

const NSInteger kSearchStoreProxyImageViewTag = 999;


@interface HPSearchStoreViewController () {
    NSMutableArray* _thumbnailProxyViewArray;
    HPStoreFetcher* _fetcher;
}

@end

@implementation HPSearchStoreViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(!(self = [super initWithCoder:aDecoder])) {
        return nil;
    }
    
    //
    _fetcher = [[HPStoreFetcher alloc] init];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _thumbnailProxyViewArray = [[NSMutableArray alloc] init];
}

- (void) viewWillAppear:(BOOL)animated {
    if([_thumbnailProxyViewArray count] == 0){
        
        //
        NSNumber *typeNumber = nil;
        NSString *code = nil;
        
        if(_areaCode) {
            typeNumber = [HPPropertyListUtility valueForKeyOfMaster:@"kSearchTypeNumberArea" master:@"masterData"];
            code = _areaCode;
        }else if(_specialCode){
            typeNumber = [HPPropertyListUtility valueForKeyOfMaster:@"kSearchTypeNumberSpecial" master:@"masterData"];
            code = _specialCode;
        }
        
        //
        [_fetcher beginFetchWithTypeNumber:typeNumber
                                 codeValue:code
                               successTask:^(){
                                   //
                                   [self.tableView reloadData];
                               }
                                   rowTask:^(HPStoreEntity *store) {
                                       
                                       //
                                       HPThumbnailProxyView *v = [[HPThumbnailProxyView alloc] init];
                                       v.imageURL = store.imageURL;
                                       
                                       //
                                       CGFloat x = [[HPPropertyListUtility valueForKeyOfMaster:@"kCellOriginPositionX"
                                                                                        master:@"masterData"] intValue];
                                       CGFloat y = [[HPPropertyListUtility valueForKeyOfMaster:@"kCellOriginPositionY"
                                                                                        master:@"masterData"] intValue];
                                       CGFloat width = [[HPPropertyListUtility valueForKeyOfMaster:@"kCellSubviewSizeWidth"
                                                                                            master:@"masterData"] intValue];
                                       CGFloat height = [[HPPropertyListUtility valueForKeyOfMaster:@"kCellSubviewSizeHeight"
                                                                                             master:@"masterData"] intValue];
                                       [v setFrame:CGRectMake(x, y, width, height)];
                                       
                                       //
                                       [_thumbnailProxyViewArray addObject:v];
                                   }
                                 errorTask:^(NSError *error) {
                                     
                                     //
                                     [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Confirmation", nil)
                                                                 message:[error localizedDescription]
                                                                delegate:[UIApplication sharedApplication].delegate
                                                       cancelButtonTitle:NSLocalizedString(@"Yes", nil)
                                                       otherButtonTitles:nil] show];
                                 }];
    }
    
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [_fetcher stopFetching];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) resetViewControllerData {
    //
    for(HPThumbnailProxyView *proxyView in _thumbnailProxyViewArray) {
        [proxyView removeFromSuperview];
    }
    
    //
    [_thumbnailProxyViewArray removeAllObjects];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (!(self.isViewLoaded && self.view.window)) {
        [self resetViewControllerData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetcher numberOfStore];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"storeInfoCell";
    HPSearchStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    [[cell.contentView viewWithTag:kSearchStoreProxyImageViewTag] removeFromSuperview];
    
    //
    if([_thumbnailProxyViewArray count] > 0) {
        HPThumbnailProxyView *proxyImage = [_thumbnailProxyViewArray objectAtIndex: indexPath.row];
        proxyImage.tag = kSearchStoreProxyImageViewTag;
        [cell.contentView addSubview: proxyImage];
    }
    
    //
    if([_fetcher numberOfStore] > 0) {
        cell.storeNameLabel.text = [_fetcher storeEntityAtIndex:indexPath.row].name;
    }else{
        cell.storeNameLabel.text = @"";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //
    if ([[segue identifier] isEqualToString:@"searchStoreSegue"]) {
        
        //
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        HPStoreEntity *store = [_fetcher storeEntityAtIndex:selectedIndexPath.row];
        
        //
        HPStoreDetailViewController *vc = (HPStoreDetailViewController*)[segue destinationViewController];
        vc.storeEntity = store;
        vc.thumbnailImage = (UIImage *)[[_thumbnailProxyViewArray objectAtIndex:selectedIndexPath.row] image];
    }
    
}

@end
