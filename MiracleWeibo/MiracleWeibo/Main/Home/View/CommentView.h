//
//  CommentView.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/28.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "CommentViewCell.h"
#import "WeiboView.h"
#import "RegexKitLite.h"
@interface CommentView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ThemeLabel *time;
@property (nonatomic, strong) ThemeLabel *from;
@property (nonatomic, strong) ThemeImageView *userImage;
@property (nonatomic, strong) ThemeLabel *userName;

@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) WeiboView *weiboView;
@property (nonatomic, strong) WeiboViewLayout *weiboFrame;
@end
