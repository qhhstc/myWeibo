//
//  MainViewController.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainViewController : UITabBarController<SinaWeiboRequestDelegate>

@property (nonatomic,assign)NSInteger selectIndex;

@end
