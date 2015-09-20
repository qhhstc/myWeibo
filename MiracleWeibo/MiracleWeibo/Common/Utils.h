//
//  Utils.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/24.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSDate *)dateWithStr:(NSString *)str formatterStr:(NSString *)formatterStr;
+ (NSString *)stringWithDate:(NSDate *)date formatterStr:(NSString *)formatterStr;

+ (NSString *)weiboDateString:(NSString *)string;

@end
