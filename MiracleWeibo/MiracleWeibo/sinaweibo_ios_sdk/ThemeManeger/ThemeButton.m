//
//  ThemeButton.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 01/1/1.
//  Copyright (c) 2001年 no.4. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton
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

- (void)themeDidChange:(NSNotification *)notification{
    [self loadImage];
}

- (void)loadImage{
    ThemeManager *manager = [ThemeManager shareThemeManager];
    UIImage *normalImage = [manager getThemeImage:self.normalImgName];
    [self setImage:normalImage forState:UIControlStateNormal];
    
    UIImage *highlightImg = [manager getThemeImage:self.highlightImgName];
    [self setImage:highlightImg forState:UIControlStateHighlighted];
    
    UIImage *normalbgImage = [manager getThemeImage:self.normalbgImgName];
    [self setBackgroundImage:normalbgImage forState:UIControlStateNormal];
    
    UIImage *highlightbgImg = [manager getThemeImage:self.highlightbgImgName];
    [self setBackgroundImage:highlightbgImg forState:UIControlStateHighlighted];
}

- (void)setNormalImgName:(NSString *)normalImgName{
    if (_normalImgName != normalImgName) {
        _normalImgName = [normalImgName copy];
    }
    [self loadImage];
}

- (void)setNormalbgImgName:(NSString *)normalbgImgName{
    if (_normalbgImgName != normalbgImgName) {
        _normalbgImgName = [normalbgImgName copy];
        [self loadImage];
    }
}

- (void)setHighlightImgName:(NSString *)highlightImgName{
    if (_highlightImgName != highlightImgName) {
        _highlightImgName = [highlightImgName copy];
        [self loadImage];
    }
}

- (void)setHighlightbgImgName:(NSString *)highlightbgImgName{
    if (_highlightbgImgName != highlightbgImgName) {
        _highlightbgImgName = [highlightbgImgName copy];
        [self loadImage];
    }
}

- (void)awakeFromNib{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotification object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
