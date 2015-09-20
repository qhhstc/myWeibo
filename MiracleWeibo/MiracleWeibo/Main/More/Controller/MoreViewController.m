//
//  MoreViewController.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/19.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "MoreViewController.h"
#import "AppDelegate.h"
#import "ThemeManager.h"
#import "ThemeButton.h"
#import "SinaWeibo.h"
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_table;
    NSMutableArray *array;
}
@end

@implementation MoreViewController

- (void)loadArray{
    array = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    for (NSString *key in [dic allKeys]) {
        [array addObject:key];
    }
}

- (void)createTable{
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64) style:UITableViewStyleGrouped];
    _table.dataSource = self;
    _table.delegate = self;
    _table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_table];
    [_table registerClass:[MoreTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTableViewCell *cell = [[MoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    manager = [ThemeManager shareThemeManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotification object:nil];
    cell.backgroundColor = [manager getThemeColor:@"More_Item_color"];
    cell.cellName.colorName = @"More_Item_Text_color";
    cell.themeName.colorName = @"More_Item_Text_color";
    if (indexPath.section == 0 && indexPath.row ==0) {
        cell.imgView.imgName = @"/more_icon_theme.png";
        cell.cellName.text = @"主题选择";
        cell.themeName.text = manager.themeName;
    }
    if (indexPath.section == 0 && indexPath.row ==1) {
        cell.imgView.imgName = @"/more_icon_account.png";
        cell.cellName.text = @"账号管理";
    }
    if (indexPath.section == 1) {
        cell.imgView.imgName = @"/more_icon_feedback.png";
        cell.cellName.text = @"意见反馈";
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [manager getThemeColor:@"More_Item_Text_color"];
        cell.accessoryType = UITableViewCellEditingStyleNone;
    }
    
    return cell;
}

- (void)themeDidChange:(NSNotification *)notification{
    [_table reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *cell = (MoreTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    if (indexPath.section == 0 &&indexPath.row == 0) {
        ThemeViewController *vc = [[ThemeViewController alloc] init];
        vc.array = array;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2) {
        UIAlertView *cancel = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否退出登录" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [cancel show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {

    }
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    }
}

- (SinaWeibo *)sinaweibo
{
    AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadArray];
    [self createTable];
    // Do any additional setup after loading the view.
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
