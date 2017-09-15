//
//  HPSearchTopViewController.m
//  HotPepper
//
//

#import "HPSearchTopViewController.h"

@interface HPSearchTopViewController ()

@end

@implementation HPSearchTopViewController

- (void) viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if (!(self.isViewLoaded && self.view.window)) {
        
    }
}


@end
