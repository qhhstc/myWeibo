//
//  AppDelegate.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    
    UIViewController * leftSideDrawerViewController = [[LeftViewController alloc] init];
    
    UIViewController * centerViewController = [[MainViewController alloc] init];
    
    UIViewController * rightSideDrawerViewController = [[RightViewController alloc] init];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:centerViewController
                                             leftDrawerViewController:leftSideDrawerViewController
                                             rightDrawerViewController:rightSideDrawerViewController];
    [drawerController setMaximumRightDrawerWidth:75.0];
    [drawerController setMaximumLeftDrawerWidth:125.0];

    //设置动画区域
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置动画类型
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    
    //设置动画效果
    [drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = drawerController;

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
