//
//  Utils.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/24.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+ (NSDate *)dateWithStr:(NSString *)str formatterStr:(NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSDate *date = [formatter dateFromString:str];
    return date;

}

+ (NSString *)stringWithDate:(NSDate *)date formatterStr:(NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *)weiboDateString:(NSString *)string{
    NSString *formatterStr = @"E MMM dd HH:mm:ss Z yyyy";

    NSDate *date = [Utils dateWithStr:string formatterStr:formatterStr];

    NSString *formatter = @"MM-dd HH:mm:ss";

    NSString *str = [Utils stringWithDate:date formatterStr:formatter];
    return str;
}
@end
