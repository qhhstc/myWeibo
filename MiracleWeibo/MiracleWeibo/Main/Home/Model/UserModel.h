//
//  UserModel.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/23.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel
@property (nonatomic,retain) NSString *profileImage;
@property(nonatomic,copy)NSString *idstr;           //字符串型的用户UID
@property(nonatomic,copy)NSString *screen_name;     //用户昵称
@property(nonatomic,copy)NSString *name;            //友好显示名称
@property(nonatomic,copy)NSString *location;        //用户所在地
@property(nonatomic,copy)NSString *userDescription;     //用户个人描述
@property(nonatomic,copy)NSString *url;             //用户博客地址

@property(nonatomic,copy)NSString * avatar_large;  //用户大头像地址
@property(nonatomic,copy)NSString * gender;             //性别，m：男、f：女、n：未知
@property(nonatomic,retain)NSNumber * followers_count;    //粉丝数
@property(nonatomic,retain)NSNumber * friends_count;   //关注数
@property(nonatomic,retain)NSNumber * statuses_count;   //微博数
@property(nonatomic,retain)NSNumber * favourites_count;   //收藏数
@property(nonatomic,retain)NSNumber * verified;   //是否是微博认证用户，即加V用户，true：是，false：否
@end
