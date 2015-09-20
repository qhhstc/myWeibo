//
//  WeiboView.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/24.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "WeiboView.h"
#import "RegexKitLite.h"
@implementation WeiboView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (void)themeDidChange:(NSNotification *)notification{
    _textLabel.textColor = [[ThemeManager shareThemeManager] getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManager shareThemeManager] getThemeColor:@"Timeline_Content_color"];
}

- (void)setWeiboLayout:(WeiboViewLayout *)weiboLayout{
    if (_weiboLayout != weiboLayout) {
        _weiboLayout = weiboLayout;
        [self setNeedsLayout];
    }
}

- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel{
    return [[ThemeManager shareThemeManager] getThemeColor:@"Link_color"];
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel{
    return [UIColor redColor];
}

- (void)createSubview{
    
    
    //1 微博内容
    ThemeManager *manager = [ThemeManager shareThemeManager];
    
    _textLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _textLabel.font = [UIFont systemFontOfSize:16];
    _textLabel.wxLabelDelegate = self;
    _textLabel.linespace = 5;
    UIColor *textColor = [manager getThemeColor:@"Timeline_Content_color"];
    _textLabel.textColor = textColor;
    
    [self addSubview:_textLabel];
    
    
    //2 原微博内容
    _sourceLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.linespace = 5;
    _sourceLabel.wxLabelDelegate = self;
    _sourceLabel.font = [UIFont systemFontOfSize:15];
    _sourceLabel.textColor = textColor;
    [self addSubview:_sourceLabel];
    
    
    //3 图片
    _imgView = [[ZoomImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_imgView];
    
    //4 原微博背景图片
    
    _bgImgView = [[ThemeImageView alloc] initWithFrame:CGRectZero];
    //拉伸点设置
    _bgImgView.leftCapWidth = 25;
    _bgImgView.topCapWidth = 25;
    _bgImgView.imgName = @"/timeline_rt_border_9.png";
    
    [self addSubview:_bgImgView];
    [self insertSubview:_bgImgView atIndex:0];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    GettedWeibo *weiboModel = self.weiboLayout.weiboModel;
    
    _textLabel.frame = self.weiboLayout.textFrame;
    _textLabel.text = weiboModel.text;
    //  微博是否是转发的
    if (weiboModel.reWeibo != nil) {
        UserModel *user = [[UserModel alloc] initWithDataDic:weiboModel.reWeibo.user];
        
        self.bgImgView.hidden = NO;
        self.sourceLabel.hidden = NO;
        //原微博背景图片frame
        self.bgImgView.frame = self.weiboLayout.bgImgFrame;
        //原微博内容及frame

        self.sourceLabel.text = [NSString stringWithFormat:@"@%@:%@",user.screen_name,weiboModel.reWeibo.text];
        self.sourceLabel.frame = self.weiboLayout.srTextFrame;
        
        NSString *imgUrl = weiboModel.reWeibo.thumbnailImage;
        NSString *bigUrl = weiboModel.reWeibo.originalImage;
        if (imgUrl != nil) {
            self.imgView.hidden = NO;
            self.imgView.frame = self.weiboLayout.imgFrame;
            self.imgView.fullUrl = bigUrl;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        }else{
            
            self.imgView.hidden = YES;
        }
    }else{
        self.bgImgView.hidden = YES;
        self.sourceLabel.hidden = YES;
        NSString *imgUrl = weiboModel.thumbnailImage;
        //是否有图片
        NSString *bigUrl = weiboModel.originalImage;
        if (imgUrl == nil) {
            self.imgView.hidden = YES;
        }else{
            self.imgView.hidden = NO;
            self.imgView.frame = self.weiboLayout.imgFrame;
            self.imgView.fullUrl = bigUrl;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        }
        
    }

    if (self.imgView.hidden == NO) {
        UIImageView *icon = self.imgView.iconImage;
        icon.frame = CGRectMake(self.imgView.width - 24, self.imgView.height -15, 24, 15);
        NSString *extension = [weiboModel.thumbnailImage pathExtension];
        if ([extension isEqualToString:@"gif"]) {
            self.imgView.isGif = YES;
            icon.hidden = NO;
        }
        else {
            self.imgView.isGif = NO;
            icon.hidden = YES;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
