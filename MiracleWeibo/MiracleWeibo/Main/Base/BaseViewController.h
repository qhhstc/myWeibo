//
//  BaseViewController.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworking.h"
@interface BaseViewController : UIViewController{
    UIView *_tipView; //自己实现
    MBProgressHUD *_hud;
    UIWindow *_tipWindow;//状态栏提示
}

//显示加载提示-自己实现
- (void)showLoading:(BOOL)show;

//显示hud提示-开源代码
- (void)showHUD:(NSString *)title;
- (void)hideHUD;
//完成的提示
- (void)completeHUD:(NSString *)title;

- (void)setNavItem;
- (void)setBgImage;

//状态栏提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation;

@end
