//
//  UserModel.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/23.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (NSDictionary *)attributeMapDictionary{
    NSDictionary *dic = @{
                          @"profileImage":@"profile_image_url",
                          @"screen_name":@"screen_name"
                          };
    return dic;
}
@end
