//
//  WeiboViewLayout.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/24.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GettedWeibo.h"
#import "WXLabel.h"
@interface WeiboViewLayout : NSObject

@property (nonatomic,assign) CGRect textFrame;
@property (nonatomic,assign) CGRect srTextFrame;
@property (nonatomic,assign) CGRect bgImgFrame;
@property (nonatomic,assign) CGRect imgFrame;

@property (nonatomic,assign) CGRect frame;

@property (nonatomic,strong) GettedWeibo *weiboModel;
@end
