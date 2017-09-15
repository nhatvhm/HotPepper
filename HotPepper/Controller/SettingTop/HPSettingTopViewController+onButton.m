//
//  HPSettingTopViewController+onButton.m
//  HotPepper
//
//

#import "HPSettingTopViewController+onButton.h"
#import "HPBookmarkManager.h"
#import "HPUserDefaultsUtility.h"


NSString *const kAlertViewTitle = @"Confirmation";
NSString *const kAlertViewMessage = @"Communication error";
NSString *const kAlertViewButtonTitle = @"Yes";

@implementation HPSettingTopViewController (onButton)

#pragma mark - Action Sheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        //
        NSInteger result;
        [[HPBookmarkManager sharedInstance] deleteAllBookmark];
    }
    
}



- (IBAction)onButtonClearBookmark:(id)sender {
    
    //
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Do you want to delete all?"
                                                        delegate:self
                                               cancelButtonTitle:@"No"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"Yes",nil];
    
    //
    action.actionSheetStyle = UIBarStyleDefault;
    [action showInView:[UIApplication sharedApplication].keyWindow];
    
    
}

- (IBAction)onButtonInitializeApp:(id)sender {
    
    //
    self.settingResultNumSegment.selectedSegmentIndex = 0;
    [self.settingHourSwitch setOn:NO];
    [self.settingCouponSwitch setOn:NO];
    
    //
    [[HPUserDefaultsUtility sharedInstance] rollbackDefaults];
    
    //
    [[HPBookmarkManager sharedInstance] deleteAllBookmark];
    
    //
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAlertViewTitle
                                                    message:@"HotPepper!"
                                                   delegate:[UIApplication sharedApplication].delegate
                                          cancelButtonTitle:kAlertViewButtonTitle
                                          otherButtonTitles:nil];
    [alert show];
    
    
}


@end
