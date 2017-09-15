//
//  HPSearchSpecialViewController.m
//  HotPepper
//
//

#import "HPSearchSpecialViewController.h"

#import "HPSpecialFetcher.h"
#import "HPSearchStoreViewController.h"

@interface HPSearchSpecialViewController () {
    HPSpecialFetcher* _fetcher;
}

@end

@implementation HPSearchSpecialViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(!(self = [super initWithCoder:aDecoder])) {
        return nil;
    }
    
    //
    _fetcher = [[HPSpecialFetcher alloc] init];
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [_fetcher beginFetchWithSuccessTask:^() {
        [self.tableView reloadData];
    }
                              errorTask:^(NSError *error) {
                                  
                                  //
                                  [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"確認", nil)
                                                              message:[error localizedDescription]
                                                             delegate:[UIApplication sharedApplication].delegate
                                                    cancelButtonTitle:NSLocalizedString(@"はい", nil)
                                                    otherButtonTitles:nil] show];
                              }
     ];

}

- (void) viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
}

- (void) viewWillDisappear:(BOOL)animated {
    [_fetcher stopFetching];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if (!(self.isViewLoaded && self.view.window)) {
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetcher numberOfSpecial];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SpecialTitleCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
    }
    cell.textLabel.text = [_fetcher specialEntityAtIndex:indexPath.row].name;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //
    if ([[segue identifier] isEqualToString:@"specialCodeSegue"]) {
        HPSearchStoreViewController *vc = (HPSearchStoreViewController*)[segue destinationViewController];
        vc.specialCode = [_fetcher specialEntityAtIndex:[self.tableView indexPathForSelectedRow].row].code;
    }
    
}

@end
