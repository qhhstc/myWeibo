//
//  RightViewController.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/22.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "RightViewController.h"
#import "PostWeiboViewController.h"
#import "ThemeButton.h"
#import "BaseNavController.h"
@interface RightViewController ()

@end

@implementation RightViewController



- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBgImage];
    
    
    // 图片的数组
    NSArray *imageNames = @[@"/newbar_icon_1.png",
                            @"/newbar_icon_2.png",
                            @"/newbar_icon_3.png",
                            @"/newbar_icon_4.png",
                            @"/newbar_icon_5.png"];
    
    // 创建主题按钮
    for (int i = 0; i < imageNames.count; i++) {
        // 创建
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(20, 64 + i * (40 + 10), 40, 40)];
        button.normalImgName = imageNames[i];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)buttonAction:(UIButton *)button{
    if (button.tag == 0) {
        // 发送微博
            // 弹出发送微博控制器
            
            PostWeiboViewController *senderVc = [[PostWeiboViewController alloc] init];
            senderVc.title = @"发送微博";
            
            // 创建导航控制器
            BaseNavController *baseNav = [[BaseNavController alloc] initWithRootViewController:senderVc];
            [self presentViewController:baseNav animated:YES completion:nil];
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
