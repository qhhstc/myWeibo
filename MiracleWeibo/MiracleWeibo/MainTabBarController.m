//
//  MainTabBarController.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubVc];
    // Do any additional setup after loading the view.
}

- (void)createSubVc{
    NSArray *names = @[@"Home",@"Message",@"Discover",@"Profile",@"More"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [names count]; i++) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:names[i] bundle:nil];
        UINavigationController *nav = [storyboard instantiateInitialViewController];
        [array addObject:nav];
    }
    self.viewControllers = array;
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

@end
