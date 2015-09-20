//
//  CommentModel.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/28.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "CommentModel.h"
#import "RegexKitLite.h"
@implementation CommentModel
- (NSDictionary*)attributeMapDictionary{
    
    //   @"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"text":@"text",
                             @"favorited":@"favorited",
                             @"user":@"user",
                             @"maxId":@"id"
                             };
    
    return mapAtt;
}

- (void)setAttributes:(NSDictionary *)dataDic{
    [super setAttributes:dataDic];
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic != nil) {
        self.userModel = [[UserModel alloc] initWithDataDic:userDic];
    }
    //将微博内容中 表情转换成图片，正则表达式
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

