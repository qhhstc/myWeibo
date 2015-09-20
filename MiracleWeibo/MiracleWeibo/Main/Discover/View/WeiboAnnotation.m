//
//  WeiboAnnotation.m
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/9/2.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "WeiboAnnotation.h"
#import "UIImageView+WebCache.h"
@implementation WeiboAnnotation
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        NSLog(@"!33333333333333");
    }
    return self;
}

- (void)createView{
    _userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_userHeadImageView];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _textLabel.backgroundColor = [UIColor whiteColor];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.numberOfLines = 3;
    [self addSubview:_textLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _userHeadImageView.frame = CGRectMake(0, 0, 60, 60);
    _textLabel.frame = CGRectMake(60, 0, 100, 60);
    
    WeiboAnnotationModel *annotation = self.annotation;
    
    _textLabel.text = annotation.weibo.text;
    NSLog(@"%@",_textLabel.text);
    [_userHeadImageView sd_setImageWithURL:[NSURL URLWithString:annotation.weibo.userModel.profileImage]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
