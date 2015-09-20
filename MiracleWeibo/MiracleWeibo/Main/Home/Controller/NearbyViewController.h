//
//  NearbyViewController.h
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/9/1.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^block) (NSString *);
@interface NearbyViewController : BaseViewController
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,copy) block b;
@end
