//
//  ThemeManager.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/21.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeDidChangeNotification @"kThemeDidChangeNotification"

@interface ThemeManager : NSObject

@property (nonatomic,retain)NSDictionary *themeConfig;
@property (nonatomic,retain)NSString *themeName;
@property (nonatomic,retain)NSDictionary *colorConfig;

+ (ThemeManager *)shareThemeManager;
- (UIImage *)getThemeImage:(NSString *)themeImageName;
- (UIColor *)getThemeColor:(NSString *)themeColorName;
@end
