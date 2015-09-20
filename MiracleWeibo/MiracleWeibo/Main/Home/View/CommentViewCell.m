//
//  CommentViewCell.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/28.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "CommentViewCell.h"

@implementation CommentViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setComment:(CommentModel *)comment{
    if (_comment != comment) {
        _comment = comment;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.commentTime.text = [Utils weiboDateString:self.comment.createDate];
    
    self.comment.userModel = [[UserModel alloc] initWithDataDic:self.comment.user];
    [self.commentImage sd_setImageWithURL:[NSURL URLWithString:self.comment.userModel.profileImage]];
    
    self.commentName.text = self.comment.userModel.screen_name;
    self.commentName.colorName = @"Timeline_Name_color";
    
    self.commentText.text = self.comment.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
