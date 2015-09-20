//
//  CommentViewCell.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/28.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeLabel.h"
#import "ThemeImageView.h"
#import "CommentModel.h"
#import "Utils.h"
#import "UIImageView+WebCache.h"
@interface CommentViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ThemeImageView *commentImage;
@property (weak, nonatomic) IBOutlet ThemeLabel *commentName;
@property (weak, nonatomic) IBOutlet ThemeLabel *commentTime;
@property (weak, nonatomic) IBOutlet ThemeLabel *commentText;


@property (nonatomic, strong) CommentModel *comment;
@end
