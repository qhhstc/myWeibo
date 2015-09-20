//
//  CommentModel.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/28.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
@interface CommentModel : BaseModel
@property(nonatomic,copy)NSString       *createDate;       //微博创建时间
@property(nonatomic,copy)NSString       *text;
@property(nonatomic,retain)NSNumber     *favorited;         //是否已收藏
@property(nonatomic,retain)NSNumber     *maxId;
@property(nonatomic,retain)NSDictionary *user;


@property (nonatomic,retain)UserModel *userModel;
@end
