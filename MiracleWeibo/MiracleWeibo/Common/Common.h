//
//  Common.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#ifndef MiracleWeibo_Common_h
#define MiracleWeibo_Common_h
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#define kVersion        [UIDevice currentDevice].systemVersion.floatValue;

#define unread_count    @"remind/unread_count.json"  //未读消息
#define home_timeline   @"statuses/home_timeline.json"  //微博列表
#define comments        @"comments/show.json"   //评论列表
#define perURL          @"https://api.weibo.com"
#define getHomeList     @"/2/statuses/home_timeline.json"
#define postWeibo       @"/2/statuses/update.json"
#define postWeiboIMage  @"/2/statuses/upload.json"
#define geo_address     @"/2/location/geo/geo_to_address.json"
#define nearbyPois      @"/2/place/nearby/pois.json"
#define nearbyWeibo     @"/2/place/nearby_timeline.json"
#define TokenValue      @"2.00MzwrSCdDYaWD4afb1d4f4fQDUMrB"
#define Token           @"access_token"
#endif 
