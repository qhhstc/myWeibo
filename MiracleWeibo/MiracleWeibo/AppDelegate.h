//
//  AppDelegate.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#define kAppKey             @"3229951977"
#define kAppSecret          @"cf490fde203ba288cd63d420ca38d56c"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"

@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>
@property (strong, nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) UIWindow *window;
@end

