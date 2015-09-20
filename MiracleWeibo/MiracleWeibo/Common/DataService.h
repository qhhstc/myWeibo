//
//  DataService.h
//  XLWeibo
//
//  Created by 天才邱海晖 on 15/8/12.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworking.h"
typedef void (^blocktype) (id result);

@interface DataService : NSObject

+ (AFHTTPRequestOperation *)requestWeiboURL:(NSString *)url
                 method:(NSString *)method
                 params:(NSDictionary *)params
                  datas:(NSDictionary *)datas
                 withBlock:(blocktype) block;

+ (void)getHomeWeibo;
+ (AFHTTPRequestOperation *)sendWeiboContent:(NSString *)content image:(UIImage *)img completion:(blocktype)block ;

@end
