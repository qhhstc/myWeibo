//
//  ZoomImageView.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/29.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "ZoomImageView.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
@implementation ZoomImageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatTap];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)creatTap{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIn)];
    [self addGestureRecognizer:tap];
    
}

- (void)zoomIn{
    
    if ([self.delegate respondsToSelector:@selector(willZoomIn:)]) {
        [self.delegate willZoomIn:self];
    }
    self.hidden = YES;
    
    
    [self createScroll];
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _fullImageView.frame = frame;
    [UIView animateWithDuration:.5 animations:^{
        _fullImageView.frame = _scrollView.bounds;
    } completion:^(BOOL finished) {
        _scrollView.backgroundColor = [UIColor blackColor];
    }];
    
    if (self.fullUrl.length > 0) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.fullUrl]];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        _task = [session downloadTaskWithRequest:request];
        [_task resume];
    }
}

- (void)zoomOut{
    if ([self.delegate respondsToSelector:@selector(willZoomOut:)]) {
        [self.delegate willZoomOut:self];
    }
    
    self.hidden = NO;
    [UIView animateWithDuration:.5 animations:^{
        _scrollView.backgroundColor = [UIColor clearColor];
        CGRect frame = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = frame;
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        _fullImageView = nil;
        _scrollView = nil;
        _progress = nil;
    }];
}

- (void)createScroll{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.window addSubview:_scrollView];
    
    _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    _fullImageView.image = self.image;
    [_scrollView addSubview:_fullImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOut)];
    [_scrollView addGestureRecognizer:tap];
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [_scrollView addGestureRecognizer:longPress];
    
    
    _progress = [[DDProgressView alloc] initWithFrame:CGRectMake(0, kHeight/2, kWidth-20, 40)];
    _progress.innerColor = [UIColor whiteColor];
    _progress.outerColor = [UIColor greenColor];
    _progress.emptyColor = [UIColor lightGrayColor];
    _progress.hidden = YES;
    [_scrollView addSubview:_progress];
    
}

- (void)longPress:(UILongPressGestureRecognizer *)longP{
    if (longP.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UIImage *img = _fullImageView.image;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        hud.labelText = @"正在保存";
        hud.dimBackground = YES;
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:DidFinishWith:context:), (__bridge void*)(hud));
    }
}

- (void)image:(UIImage *)img DidFinishWith:(NSError *)error context:(void *)context{
    MBProgressHUD *hud = (__bridge MBProgressHUD *)context;
    
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //显示模式改为：自定义视图模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    //延迟隐藏
    [hud hide:YES afterDelay:1.5];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
    //下载下来是存在tmp中 临时的文件夹，要复制出来。
    
    _destination = [self createDirectoryForDownloadItemFromURL:location];
    if ([self copyTempFileAtURL:location toDestination:_destination]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _progress.hidden = YES;
            UIImage *image= [UIImage imageWithContentsOfFile:[_destination path]];
            _fullImageView.image = image;
            
            //处理imageView尺寸
            // 图片的长/图片的宽 ==  ImageView.长（？）/屏幕宽
            [UIView animateWithDuration:0.5 animations:^{
                
                CGFloat length = image.size.height/image.size.width * kWidth;
                if (length < kHeight) {
                    _fullImageView.top = (kHeight-length)/2;
                }
                _fullImageView.height = length;
                _scrollView.contentSize = CGSizeMake(kWidth, length);
                
            } completion:^(BOOL finished) {
                _scrollView.backgroundColor = [UIColor blackColor];
            }];
            if (self.isGif) {
                [self gifImage];
            }
        });
    }
    
    _task = nil;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    double current = totalBytesWritten/(double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        _progress.progress = current;

    });
}

-(NSURL *)createDirectoryForDownloadItemFromURL:(NSURL *)location
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = urls[0];
    return [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
}
//把文件拷贝到指定路径
-(BOOL) copyTempFileAtURL:(NSURL *)location toDestination:(NSURL *)destination
{
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:destination error:NULL];
    [fileManager copyItemAtURL:location toURL:destination error:&error];
    if (error == nil) {
        return true;
    }else{
        NSLog(@"%@",error);
        return false;
    }
}

- (void)gifImage{
    _fullImageView.image = [UIImage sd_animatedGIFWithData:[NSData dataWithContentsOfURL:_destination]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
