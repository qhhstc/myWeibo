//
//  ThemeManager.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/21.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

+ (ThemeManager *)shareThemeManager{
    static ThemeManager *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themeConfig = [NSDictionary dictionaryWithContentsOfFile:path];
        _themeName = @"猫爷";
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"themeName"]) {
            _themeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"themeName"];
        }
    }
    return self;
}

- (void)setThemeName:(NSString *)themeName{
    
    if (_themeName != themeName) {
        _themeName = [themeName copy];
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:@"themeName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:nil];
    }
}

- (UIColor *)getThemeColor:(NSString *)themeColorName{
    if (themeColorName == 0) {
        return nil;
    }
    NSString *colorPath = [[self getPath] stringByAppendingString:@"/config.plist"];
    self.colorConfig = [NSDictionary dictionaryWithContentsOfFile:colorPath];
    NSDictionary *dic = [self.colorConfig objectForKey:themeColorName];
    CGFloat r = [[dic objectForKey:@"R"] floatValue];
    CGFloat g = [[dic objectForKey:@"G"] floatValue];
    CGFloat b = [[dic objectForKey:@"B"] floatValue];
    CGFloat alpha = [[dic objectForKey:@"alpha"] floatValue];
    if ([dic objectForKey:@"alpha"] == nil) {
        alpha = 1;
    }
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    return color;
    
}

- (UIImage *)getThemeImage:(NSString *)themeImageName{
    if (themeImageName.length == 0) {
        return nil;
    }
    
    NSString *themePath = [self getPath];
    
    NSString *imagePath = [themePath stringByAppendingString:themeImageName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

- (NSString *)getPath{
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *theme = [self.themeConfig objectForKey:_themeName];
    NSString *themePath = [bundlePath stringByAppendingPathComponent:theme];
    return themePath;
}

@end
