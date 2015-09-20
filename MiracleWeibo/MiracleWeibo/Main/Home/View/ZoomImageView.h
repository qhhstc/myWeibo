//
//  ZoomImageView.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/29.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDProgressView.h"
@class ZoomImageView;
@protocol zoomImageDelegate<NSObject>
@optional
- (void)willZoomIn:(ZoomImageView *)zoom;
- (void)willZoomOut:(ZoomImageView *)zoom;

@end

@interface ZoomImageView : UIImageView<NSURLSessionDelegate,NSURLSessionDownloadDelegate>
@property (nonatomic,weak) id<zoomImageDelegate> delegate;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) UIImageView *fullImageView;
@property (nonatomic,retain) NSString *fullUrl;

@property (nonatomic,retain) DDProgressView *progress;
@property (nonatomic,retain) NSURLSessionDownloadTask *task;

@property (nonatomic,retain) UIImageView *iconImage;
@property (nonatomic,assign) BOOL isGif;
@property (nonatomic, strong)NSURL *destination;
@end
