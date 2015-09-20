//
//  MoreViewController.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeibo.h"
#import "ThemeManager.h"
#import "ThemeViewController.h"
#import "MoreTableViewCell.h"
@interface MoreViewController : BaseViewController<SinaWeiboDelegate>
{
    ThemeManager *manager;
}
@end
