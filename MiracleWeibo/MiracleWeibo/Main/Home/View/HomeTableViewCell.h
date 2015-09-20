//
//  HomeTableViewCell.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/23.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GettedWeibo.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"
#import "WeiboView.h"
#import "ThemeLabel.h"
@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ThemeLabel *time;
@property (weak, nonatomic) IBOutlet ThemeLabel *from;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet ThemeLabel *userName;

@property (nonatomic,strong) WeiboViewLayout *weiboFrame;
@property (nonatomic,strong) WeiboView *weiboView;
@end
