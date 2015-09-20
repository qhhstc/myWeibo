//
//  ProfileViewController.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/22.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "ProfileViewController.h"
#import "MyTableView.h"
#import "ThemeManager.h"
#import "UserModel.h"
#import "SinaWeibo.h"
@interface ProfileViewController ()
{
     MyTableView *_tableView;
     NSDictionary *_userDic;
     NSString *_userID;
     SinaWeiboRequest *_userRequest;
     SinaWeiboRequest *_request;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBar.translucent = YES;
 
//    [self createTable];
    //[self getUser];
    // Do any additional setup after loading the view.
}


- (SinaWeibo *)sinaweibo
{
     AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
     return delegate.sinaweibo;
}

- (void)getWeiboID{
     SinaWeibo *sinaWeibo = [self sinaweibo];
     sinaWeibo.delegate = self;
     if ([sinaWeibo isAuthValid]) {
          //NSLog(@"已经登录");
          _userRequest = [sinaWeibo requestWithURL:@"https://api.weibo.com/2/account/get_uid.json" params:nil httpMethod:@"GET" delegate:self];
     }
     else{
          [sinaWeibo logIn];
     }
}

- (void)getUser{
     SinaWeibo *sinaWeibo = [self sinaweibo];
     NSDictionary *params = @{@"uid":_userID};
     _request = [sinaWeibo requestWithURL:@"https://api.weibo.com/2/users/show.json" params:[params mutableCopy] httpMethod:@"GET" delegate:self];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
     if ([request isEqual:_userRequest]) {
          NSDictionary *d = (NSDictionary *)result;
          _userID = [d objectForKey:@"uid"];
          [self getUser];
          NSLog(@"%@",_userID);
     }
     if ([request isEqual:_request]) {
          _userDic = (NSDictionary *)result;
          NSLog(@"223%@",_userDic);
     }
}

- (void)createTable{
    _tableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStyleGrouped];
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
