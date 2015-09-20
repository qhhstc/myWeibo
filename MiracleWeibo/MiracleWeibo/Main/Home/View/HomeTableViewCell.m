//
//  HomeTableViewCell.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/23.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "Utils.h"
#import "RegexKitLite.h"
@implementation HomeTableViewCell

- (void)awakeFromNib {
    self.weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.weiboView];
    self.backgroundColor = [UIColor clearColor];
    // Initialization code
}

-(void)setWeiboFrame:(WeiboViewLayout *)weiboFrame{
    if (_weiboFrame != weiboFrame) {
        _weiboFrame = weiboFrame;
        [self setNeedsLayout];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    GettedWeibo *weibo = self.weiboFrame.weiboModel;
    
    self.time.text = [Utils weiboDateString:weibo.createDate];
    NSLog(@"%@",weibo.createDate);
    NSString *regex = @">.*<";
    self.from.text = @"无无无";
    if ([weibo.source componentsMatchedByRegex:regex].count>0) {
        NSString *s = [weibo.source componentsMatchedByRegex:regex][0];
        self.from.text = [NSString stringWithFormat:@"From:%@",[s substringWithRange:NSMakeRange(1, s.length-2)]];
    }
    
    self.from.colorName = @"Timeline_Content_color";
    
    weibo.userModel = [[UserModel alloc] initWithDataDic:weibo.user];
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:weibo.userModel.profileImage]];
    
    self.userName.text = weibo.userModel.screen_name;
    self.userName.colorName = @"Timeline_Name_color";
    
    [self.weiboView setWeiboLayout:self.weiboFrame];
    self.weiboView.frame = self.weiboFrame.frame;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
