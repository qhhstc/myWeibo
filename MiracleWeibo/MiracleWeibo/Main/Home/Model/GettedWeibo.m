//
//  GettedWeibo.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/22.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "GettedWeibo.h"
#import "RegexKitLite.h"
@implementation GettedWeibo

#pragma -mark 映射字典
- (NSDictionary*)attributeMapDictionary{
    
    //   @"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddlelImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count",
                             @"user":@"user",
                             @"picArray":@"pic_ids"
                             };
    
    return mapAtt;
}

- (void)setAttributes:(NSDictionary *)dataDic{
    [super setAttributes:dataDic];
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic != nil) {
        self.userModel = [[UserModel alloc] initWithDataDic:userDic];
    }
    NSDictionary *reDic = [dataDic objectForKey:@"retweeted_status"];
    if (reDic != nil) {
        self.reWeibo = [[GettedWeibo alloc] initWithDataDic:reDic];
    }
    
    NSString *regex = @"\\[\\w+\\]";
    NSArray *textArray = [self.text componentsMatchedByRegex:regex];
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *configArray = [NSArray arrayWithContentsOfFile:configPath];
    
    for (NSString *iconName in textArray) {
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",iconName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        NSArray *items = [configArray filteredArrayUsingPredicate:predicate];
        if (items.count > 0) {
            NSDictionary *dic = items[0];
            NSString *emoName = [dic objectForKey:@"png"];
            NSString *emo = [NSString stringWithFormat:@"<image url = '%@'>",emoName];
            self.text = [self.text stringByReplacingOccurrencesOfRegex:iconName withString:emo];
        }
    }
    
    
}
@end
