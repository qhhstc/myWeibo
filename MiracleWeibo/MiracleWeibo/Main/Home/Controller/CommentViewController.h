//
//  CommentViewController.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/28.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboView.h"
#import "ThemeLabel.h"
#import "RegexKitLite.h"
#import "Utils.h"
#import "CommentView.h"
#import "AppDelegate.h"
#import "CommentModel.h"
#import "MJRefresh.h"
@interface CommentViewController : BaseViewController<SinaWeiboRequestDelegate,SinaWeiboDelegate>

@property (nonatomic, strong) UIView *barView;
@property (nonatomic, strong) CommentView *commentTable;
@property (nonatomic, strong) WeiboViewLayout *weiboFrame;


@end
