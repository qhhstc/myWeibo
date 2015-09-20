//
//  BaseNavController.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.imgName = @"/mask_titlebar64.png";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadImage];
    // Do any additional setup after loading the view.
}

- (void)loadImage{
    ThemeManager *manager = [ThemeManager shareThemeManager];
    self.imgName = @"/mask_titlebar64.png";
    NSString *imageName= self.imgName;
    UIImage *image = [manager getThemeImage:imageName] ;
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    UIColor *color = [manager getThemeColor:@"Mask_Title_color"];
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName:color
                                 };
    self.navigationBar.titleTextAttributes = attributes;
    self.navigationBar.tintColor = color;
    
    UIImage *backgroundImage = [manager getThemeImage:@"/bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}

- (void)themeDidChange:(NSNotification *)notification{
    [self loadImage];
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
