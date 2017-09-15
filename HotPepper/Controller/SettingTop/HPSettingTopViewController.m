//
//  HPSettingTopViewController.m
//  HotPepper
//
//

#import "HPSettingTopViewController.h"
#import "HPUserDefaultsUtility.h"

@interface HPSettingTopViewController ()


@end

@implementation HPSettingTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[HPUserDefaultsUtility sharedInstance] numFetches] <= HPUserDefaultValueNumFetches) {
        self.settingResultNumSegment.selectedSegmentIndex = 0;
    } else {
        self.settingResultNumSegment.selectedSegmentIndex = 1;
    }
    
    //
    if ([[HPUserDefaultsUtility sharedInstance] useMobileCoupon]) {
        [self.settingCouponSwitch setOn:YES];
    }
    
    //
    if ([[HPUserDefaultsUtility sharedInstance] openStoreNow]) {
        [self.settingHourSwitch setOn:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (!(self.isViewLoaded && self.view.window)) {
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - On/Off of Segment control

- (IBAction)segmentAction:(UISegmentedControl *)sender
{
    HPUserDefaultsUtility *ud = [HPUserDefaultsUtility sharedInstance];
    
    if (sender.selectedSegmentIndex > 0) {
        [ud setFlagNumFetches:YES];
    } else {
        [ud setFlagNumFetches:NO];
    }
}

#pragma mark - On/Off of switch action mobile coupon

- (IBAction)switchActionMobileCoupon:(UISwitch *)sender {
    UISwitch* ui = (UISwitch *) sender;
    
    //
    HPUserDefaultsUtility *ud = [HPUserDefaultsUtility sharedInstance];
    if (ui.on > 0) {
        [ud setFlagMobileCoupon:YES];
    } else {
        [ud setFlagMobileCoupon:NO];
    }
    
}

#pragma mark - On/Off of switch action open store

//
- (IBAction)switchActionStoreOpenHour:(UISwitch *)sender
{
    UISwitch *ui = (UISwitch *) sender;
    
    //
    HPUserDefaultsUtility *ud = [HPUserDefaultsUtility sharedInstance];
    if (ui.on > 0) {
        [ud setFlagOpenStoreNow:YES];
    } else {
        [ud setFlagOpenStoreNow:NO];
    }
}


- (void)viewDidUnload {
    [super viewDidUnload];
    
    [self setSettingCouponSwitch:nil];
    [self setSettingResultNumSegment:nil];
    [self setSettingCouponSwitch:nil];
    [self setSettingHourSwitch:nil];
}



@end
