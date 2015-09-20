//
//  BaseViewController.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

    // Do any additional setup after loading the view.
}

#pragma -mark 自己实现加载提示
- (void)showLoading:(BOOL)show {
    
    if (_tipView == nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight/2-30, kWidth, 20)];
        _tipView.backgroundColor = [UIColor clearColor];
        
        //1.loading视图
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        [_tipView addSubview:activityView];
        
        //2.加载提示的Label
        UILabel *loadLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        loadLabel.backgroundColor = [UIColor clearColor];
        loadLabel.text = @"正在加载...";
        loadLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        loadLabel.textColor = [UIColor blackColor];
        [loadLabel sizeToFit];
        [_tipView addSubview:loadLabel];
        
        loadLabel.left = (kWidth-loadLabel.width)/2;
        activityView.right = loadLabel.left - 5;
    }
    
    if (show) {
        [self.view addSubview:_tipView];
    } else {
        if (_tipView.superview) {
            [_tipView removeFromSuperview];
        }
    }
}

#pragma mark 使用三方库实现加载提示
//显示hud提示
- (void)showHUD:(NSString *)title {
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view
                                    animated:YES];
    }
    [_hud show:YES];
    _hud.labelText = title;
    //_hud.detailsLabelText  //子标题
    
    //灰色的背景盖住其他视图
    _hud.dimBackground = YES;
}

- (void)hideHUD {
    
    //延迟隐藏
    //[_hud hide:YES afterDelay:(NSTimeInterval)]
    [_hud hide:YES];
}

//完成的提示
- (void)completeHUD:(NSString *)title {
    
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //显示模式改为：自定义视图模式
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = title;
    
    //延迟隐藏
    [_hud hide:YES afterDelay:1.5];
}




- (void)leftAction{
    MMDrawerController *mmController = [self mm_drawerController];
    [mmController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)rightAction{
    MMDrawerController *mmController = [self mm_drawerController];
    [mmController openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}


- (void)setNavItem{
    ThemeImageView *leftView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    ThemeButton *left = [[ThemeButton alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    ThemeLabel *leftLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(35, 5, 40, 30)];
    left.normalImgName = @"/group_btn_all_on_title.png";
    leftView.imgName = @"/button_title.png";
    leftLabel.text = @"设置";
    leftLabel.colorName = @"Mask_Button_color";
    [leftView addSubview:left];
    [leftView addSubview:leftLabel];
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftAction)];
    [leftView addGestureRecognizer:leftTap];
    [left addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    ThemeImageView *rightView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    ThemeButton *right = [[ThemeButton alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    ThemeLabel *rightLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(35, 5, 40, 30)];
    right.normalImgName = @"/button_icon_plus.png";
    rightView.imgName = @"/button_m.png";
    rightLabel.text = @"编辑";
    rightLabel.colorName = @"Mask_Button_color";
    [rightView addSubview:right];
    [rightView addSubview:rightLabel];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction)];
    [rightView addGestureRecognizer:rightTap];
    [right addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
}


#pragma -mark 设置背景图片
- (void)setBgImage{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_loadImage) name:kThemeDidChangeNotification object:nil];
    
    [self _loadImage];
}

- (void)_loadImage{
    
    ThemeManager *manager = [ThemeManager shareThemeManager];
    UIImage *img = [manager getThemeImage:@"/bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    
}

- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation{
    if (_tipWindow == nil) {
        //创建window
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        UILabel *tpLabel = [[UILabel alloc] initWithFrame:_tipWindow.bounds];
        tpLabel.backgroundColor = [UIColor blackColor];
        tpLabel.textAlignment = NSTextAlignmentCenter;
        tpLabel.font = [UIFont systemFontOfSize:13.0f];
        tpLabel.textColor = [UIColor whiteColor];
        tpLabel.tag = 100;
        [_tipWindow addSubview:tpLabel];
        
        //进度条
        UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progress.frame = CGRectMake(0, 17, kWidth, 4);
        progress.tag = 101;
        progress.progress = 0.0;
        [_tipWindow addSubview:progress];
    }
    
    UILabel *tpLabel = (UILabel *)[_tipWindow viewWithTag:100];
    tpLabel.text = title;
    UIProgressView *progress = (UIProgressView *)[_tipWindow viewWithTag:101];
    if (show) {
        _tipWindow.hidden = NO;
        if (operation) {
            progress.hidden = NO;
            [progress setProgressWithUploadProgressOfOperation:operation animated:YES];
        }else {
            progress.hidden = YES;
        }
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
