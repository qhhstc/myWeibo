//
//  PostWeiboViewController.h
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/8/30.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseViewController.h"
#import "ZoomImageView.h"
#import "ThemeLabel.h"
#import <CoreLocation/CoreLocation.h>

@interface PostWeiboViewController : BaseViewController<UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,zoomImageDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate>
@property (nonatomic,retain) ZoomImageView *zoomImageView;
@property (nonatomic,retain) ThemeLabel *addressText;
@end
