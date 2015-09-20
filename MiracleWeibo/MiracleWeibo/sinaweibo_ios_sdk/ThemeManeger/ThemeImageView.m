//
//  ThemeImageView.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/21.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "ThemeImageView.h"

@implementation ThemeImageView
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (void)setImgName:(NSString *)imgName
{
    if (_imgName != imgName) {
        _imgName = imgName;
        [self loadImage];
    }
}

- (void)themeDidChange:(NSNotification *)notification{
    [self loadImage];
}

- (void)loadImage{
    ThemeManager *manager = [ThemeManager shareThemeManager];
    UIImage *image = [manager getThemeImage:self.imgName];
    image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapWidth];
    self.image = image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
