//
//  MainViewController.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavController.h"
#import "ThemeLabel.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"

@interface MainViewController ()
{
    ThemeImageView *_tabBar;
    ThemeImageView *_selectedImage;
    ThemeImageView *_badgeView;
    ThemeLabel *_badgeLabel;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewController];
    [self createTabBar];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(getNum) userInfo:nil repeats:YES];
}

- (SinaWeibo *)sinaweibo
{
    AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}


- (void)getNum{
    SinaWeibo *sinaWeibo = [self sinaweibo];
    [sinaWeibo requestWithURL:@"https://api.weibo.com/2/remind/unread_count.json" params:nil httpMethod:@"GET" delegate:self];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    CGFloat tabBarButtonWidth = kWidth/4;
    if (_badgeView == nil) {
        _badgeView = [[ThemeImageView alloc] initWithFrame:CGRectMake(tabBarButtonWidth-32, 0, 32, 32)];
        _badgeView.imgName = @"/number_notify_9.png";
        [self.tabBar addSubview:_badgeView];
        
        _badgeLabel = [[ThemeLabel alloc] initWithFrame:_badgeView.bounds];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.font = [UIFont systemFontOfSize:13];
        _badgeLabel.colorName = @"/Timeline_Notice_color";
        [_badgeView addSubview:_badgeLabel];
    }
    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
    if (count > 0) {
        _badgeView.hidden = NO;
        if (count >= 100) {
            count = 99;
        }
        _badgeLabel.text = [NSString stringWithFormat:@"%li",count];
    }
    else {
        _badgeView.hidden = YES;
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    if (_selectIndex != selectIndex) {
        _selectIndex = selectIndex;
        self.selectedIndex = _selectIndex;
    }
}

- (void)selectTab:(UIButton *)button{
    
    [UIView animateWithDuration:.2 animations:^{
        _selectedImage.center = button.center;
    }];
    self.selectIndex = button.tag;
}

- (void)createViewController{
    
    NSArray *names = @[@"Home",@"Discover",@"Profile",@"More"];
    NSMutableArray *storyArray = [[NSMutableArray alloc] init];
    for (NSString *name in names) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
        BaseNavController *nav = [storyboard instantiateInitialViewController];
        [storyArray addObject:nav];
    }
    self.selectedIndex = 0;
    self.viewControllers = storyArray;
}

- (void)createTabBar{
    for (UIView *view in self.tabBar.subviews) {
        Class btn = NSClassFromString(@"UITabButton");
        if ([view isKindOfClass:btn]){
            [view removeFromSuperview];
        }
    }
    _tabBar = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, -4, kWidth, 49)];
    _tabBar.imgName = @"/mask_navbar.png";
    _tabBar.contentMode = UIViewContentModeScaleAspectFill;
    //imageview的交互要打开
    _tabBar.userInteractionEnabled = YES;
    [self.tabBar addSubview:_tabBar];

    NSArray *imgNames = @[
                          @"/home_tab_icon_1.png",
                          @"/home_tab_icon_3.png",
                          @"/home_tab_icon_4.png",
                          @"/home_tab_icon_5.png",
                          ];
    _selectedImage = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth/4, 49)];
    _selectedImage.imgName = @"/home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectedImage];
    
    for (int i = 0; i < 4; i++) {
        ThemeButton *btn = [[ThemeButton alloc] initWithFrame:CGRectMake(i*kWidth/4, 0, kWidth/4, 49)];
        btn.normalImgName = imgNames[i];
        btn.tag = i;
        [btn addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:btn];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
