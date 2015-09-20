//
//  WeiboViewLayout.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/24.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "WeiboViewLayout.h"

@implementation WeiboViewLayout
- (void)setWeiboModel:(GettedWeibo *)weiboModel{
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        [self layout];
    }
}

- (void)layout{
    //1.微博视图的frame
    self.frame = CGRectMake(5, 60, kWidth-10, 0);
    
    //2.微博内容的frame
    //1>计算微博内容的宽度
    CGFloat textWidth = CGRectGetWidth(self.frame);
    
    //2>计算微博内容的高度
    NSString *text = self.weiboModel.text;
    CGFloat textHeight = [WXLabel getTextHeight:17 width:textWidth text:text linespace:5.0];
    
    self.textFrame = CGRectMake(5, 0, textWidth, textHeight);
    
    //3.原微博的内容frame
    if (self.weiboModel.reWeibo != nil) {
        //被转发微博名字
        UserModel *user = [[UserModel alloc] initWithDataDic:self.weiboModel.reWeibo.user];
        
        
        NSString *reText = [NSString stringWithFormat:@"@%@:%@",user.screen_name,self.weiboModel.reWeibo.text];
        //1>宽度
        CGFloat reTextWidth = CGRectGetWidth(self.frame)-10;
        //2>高度
        
        CGFloat textHeight = [WXLabel getTextHeight:16 width:reTextWidth text:reText linespace:5.0];
         
        //3>Y坐标
        CGFloat Y = CGRectGetMaxY(self.textFrame);
        self.srTextFrame = CGRectMake(5, Y, reTextWidth, textHeight);
        //4.原微博的图片
        NSString *thumbnailImage = self.weiboModel.reWeibo.thumbnailImage;
        if (thumbnailImage != nil) {
            
            CGFloat Y = CGRectGetMaxY(self.srTextFrame);
            CGFloat X = CGRectGetMinX(self.srTextFrame);
            
            self.imgFrame = CGRectMake(X, Y, 80, 80);
        }
        
        //4.原微博的背景
        CGFloat bgX = 0;
        CGFloat bgY = CGRectGetMaxY(self.textFrame)-10;
        CGFloat bgWidth = CGRectGetWidth(self.textFrame);
        CGFloat bgHeight = CGRectGetMaxY(self.srTextFrame);
        if (thumbnailImage != nil) {
            bgHeight = CGRectGetMaxY(self.imgFrame);
        }
        bgHeight -= CGRectGetMaxY(self.textFrame);
        bgHeight += 20;
        
        self.bgImgFrame = CGRectMake(bgX, bgY, bgWidth, bgHeight);

    } else {
        //微博图片
        NSString *thumbnailImage = self.weiboModel.thumbnailImage;
        if (thumbnailImage != nil) {
            CGFloat imgX = CGRectGetMinX(self.textFrame);
            CGFloat imgY = CGRectGetMaxY(self.textFrame)+10;
            self.imgFrame = CGRectMake(imgX, imgY, 80, 80);
        }
        
    }
    
    //计算微博视图的高度：微博视图最底部子视图的Y坐标
    CGRect f = self.frame;
    if (self.weiboModel.reWeibo != nil) {
        f.size.height = CGRectGetMaxY(_bgImgFrame);
    }
    else if(self.weiboModel.thumbnailImage != nil) {
        f.size.height = CGRectGetMaxY(_imgFrame);
    }
    else {
        f.size.height = CGRectGetMaxY(_textFrame)+20;
    }
    self.frame = f;
    
}
@end
