//
//  HPSearchAreaViewController.m
//  HotPepper
//
//

#import "HPSearchAreaViewController.h"
#import "HPAreaFetcher.h"
#import "HPSearchStoreViewController.h"

@interface HPSearchAreaViewController () {
    HPAreaFetcher *_fetcher;
}


@end

@implementation HPSearchAreaViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(!(self = [super initWithCoder:aDecoder])) {
        return nil;
    }
    
    //
    _fetcher = [[HPAreaFetcher alloc] init];
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    if([_fetcher numberOfArea] == 0) {
        //
        [_fetcher beginFetchWithSuccessTask:^(){
            [self.tableView reloadData];
        }
                                  errorTask:^(NSError* error) {
                                      
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [_fetcher numberOfArea];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AreaTitleCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
    }
    cell.textLabel.text = [_fetcher areaEntityAtIndex:indexPath.row].name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"areaCodeSegue"]) {
        HPSearchStoreViewController *vc = (HPSearchStoreViewController *) [segue destinationViewController];
        vc.areaCode = [_fetcher areaEntityAtIndex:[self.tableView indexPathForSelectedRow].row].code;
    }
    
}


@end
