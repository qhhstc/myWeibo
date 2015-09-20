//
//  DiscoverViewController.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/22.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearbyWeiboController.h"
@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

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

- (IBAction)nearbyWb:(id)sender {
    NearbyWeiboController *vc = [[NearbyWeiboController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
