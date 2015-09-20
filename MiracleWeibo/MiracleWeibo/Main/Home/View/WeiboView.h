//
//  WeiboView.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/24.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewLayout.h"
#import "UIImageView+WebCache.h"
#import "ThemeImageView.h"
#import "WXLabel.h"
#import "ZoomImageView.h"
@interface WeiboView : UIView<WXLabelDelegate>

@property (nonatomic,retain) WXLabel *textLabel;
@property (nonatomic,retain) WXLabel *sourceLabel;
@property (nonatomic,retain) ZoomImageView *imgView;
@property (nonatomic,retain) ThemeImageView *bgImgView;

@property (nonatomic,retain) WeiboViewLayout *weiboLayout;

@end
