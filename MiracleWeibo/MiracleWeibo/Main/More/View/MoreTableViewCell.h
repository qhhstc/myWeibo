//
//  MoreTableViewCell.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/21.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeLabel.h"
@interface MoreTableViewCell : UITableViewCell

@property (nonatomic,retain)ThemeImageView *imgView;
@property (nonatomic,retain)ThemeLabel *themeName;
@property (nonatomic,retain)ThemeLabel *cellName;
@end
