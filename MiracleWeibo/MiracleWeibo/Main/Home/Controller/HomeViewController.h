//
//  HomeViewController.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/21.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeibo.h"
#import <AVFoundation/AVFoundation.h>
@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate,SinaWeiboDelegate,UITableViewDataSource,UITableViewDelegate>

@end
