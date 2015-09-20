//
//  ThemeLabel.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/21.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "ThemeLabel.h"

@implementation ThemeLabel

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadColor) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (void)setColorName:(NSString *)colorName{
    if (_colorName != colorName) {
        _colorName = colorName;
    }
    [self loadColor];

}

- (void)loadColor{
    ThemeManager *manager = [ThemeManager shareThemeManager];
    UIColor *color = [manager getThemeColor:_colorName];
    self.textColor = color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
