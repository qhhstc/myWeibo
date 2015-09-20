//
//  HomeViewController.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/21.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "HomeViewController.h"
#import "SinaWeiboRequest.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "GettedWeibo.h"
#import "WeiboViewLayout.h"
#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "CommentViewController.h"
@interface HomeViewController ()
{
    UITableView *_tableView;
    NSMutableArray *weiboLayoutArray;
    ThemeImageView *_newWeiboNum;
    ThemeLabel *_barLabel;
}
@end

@implementation HomeViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

#pragma -mark 微博登陆获取数据

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"登录");
    NSDictionary *message = @{
                              @"AccessTokenKey":sinaweibo.accessToken,
                              @"ExpirationDateKey":sinaweibo.expirationDate,
                              @"UserIDKey":sinaweibo.userID
                                  };
    [[NSUserDefaults standardUserDefaults] setObject:message forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self getWeibo];
}

- (SinaWeibo *)sinaweibo
{
    AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (void)getWeibo{
    SinaWeibo *sinaWeibo = [self sinaweibo];
    NSLog(@"%@",sinaWeibo.accessToken);
    sinaWeibo.delegate = self;
    if ([sinaWeibo isAuthValid]) {
        //NSLog(@"已经登录");
        NSDictionary *params = @{@"count":@"20"};
        SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:[params mutableCopy] httpMethod:@"GET" delegate:self];
        request.tag = 100;
        _tableView.hidden = YES;
        [self showHUD:@"正在加载"];
    }
    else{
        [sinaWeibo logIn];
    }

}

#pragma -mark MJRefresh实现下拉刷新上拉多加载

- (void)setReFresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    _tableView.header = header;
    _tableView.footer = footer;
  
    [header setTitle:@"好了吧" forState:MJRefreshStateIdle];
    [header setTitle:@"放开我" forState:MJRefreshStatePulling];
    [header setTitle:@"不要慌" forState:MJRefreshStateRefreshing];
    
 
    [footer setTitle:@"再见" forState:MJRefreshStateIdle];
    [footer setTitle:@"你看啥" forState:MJRefreshStatePulling];
    [footer setTitle:@"你再看" forState:MJRefreshStateRefreshing];
}

- (void)footerRefreshing
{

    SinaWeibo *sinaWeibo = [self sinaweibo];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"10",@"count", nil];
    if (weiboLayoutArray.count >0) {
        WeiboViewLayout *weiboFrame = [weiboLayoutArray lastObject];
        NSString *maxId = weiboFrame.weiboModel.weiboId.stringValue;
        [params setObject:maxId forKey:@"max_id"];
    }
    SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params httpMethod:@"GET" delegate:self];
    request.tag = 102;

    [_tableView.footer endRefreshing];
}

- (void)headerRereshing
{
    SinaWeibo *sinaWeibo = [self sinaweibo];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"10",@"count", nil];
    if (weiboLayoutArray.count >0) {
        WeiboViewLayout *weiboFrame = weiboLayoutArray[0];
        NSString *sinceId = weiboFrame.weiboModel.weiboId.stringValue;
        [params setObject:sinceId forKey:@"since_id"];
    }
    SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params httpMethod:@"GET" delegate:self];
    request.tag = 101;

    [_tableView.header endRefreshing];
}


- (void)request:(SinaWeiboRequest *)_request didFinishLoadingWithResult:(id)result
{
    //NSLog(@"%@",result);
    NSArray *array = [(NSDictionary *)result objectForKey:@"statuses"];
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (NSDictionary *weiDic in array) {
        GettedWeibo *weibo = [[GettedWeibo alloc] initWithDataDic:weiDic];
        WeiboViewLayout *layout = [[WeiboViewLayout alloc] init];
        layout.weiboModel = weibo;
        [a addObject:layout];
    }
    if (_request.tag == 100) {
        weiboLayoutArray = a;

        [self completeHUD:@"加载完成"];
        _tableView.hidden = NO;
    }
    if (_request.tag == 101) {
        NSRange range = NSMakeRange(0, a.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [weiboLayoutArray insertObjects:a atIndexes:set];
        [self showNumOfWeibo:a.count];
    }
    if (_request.tag == 102) {
        [a removeObjectAtIndex:0];
        [weiboLayoutArray addObjectsFromArray:a];
    }
    [_tableView reloadData];
}

#pragma -mark 创建微博tableView

- (void)createTable{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-49) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    UINib *nib = [UINib nibWithNibName:@"HomeTableViewCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [weiboLayoutArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    WeiboViewLayout *wb = weiboLayoutArray[indexPath.row];
    cell.weiboFrame = wb;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboViewLayout *weiboLayoutFrame = weiboLayoutArray[indexPath.row];
    
    CGRect frame = weiboLayoutFrame.frame;
    CGFloat height = frame.size.height;
    
    return height+100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = (HomeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CommentViewController *vc = [[CommentViewController alloc] init];
    WeiboViewLayout *wb = weiboLayoutArray[indexPath.row];
    vc.weiboFrame = wb;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma -mark 显示未读条数

- (void)showNumOfWeibo:(NSInteger)count{
    if (_newWeiboNum == nil) {
        _newWeiboNum = [[ThemeImageView alloc] initWithFrame:CGRectMake(5, -40, kWidth-10, 40)];
        _newWeiboNum.imgName = @"/timeline_notify.png";
        [self.view addSubview:_newWeiboNum];
      
        _barLabel = [[ThemeLabel alloc] initWithFrame:_newWeiboNum.bounds];
        _barLabel.colorName = @"/Timeline_Notice_color";
        _barLabel.backgroundColor = [UIColor clearColor];
        _barLabel.textAlignment = NSTextAlignmentCenter;
        [_newWeiboNum addSubview:_barLabel];
    }
    if (count > 0) {
        _barLabel.text = [NSString stringWithFormat:@"有%li条新微博!",count];
        [UIView animateWithDuration:.6 animations:^{
            _newWeiboNum.transform = CGAffineTransformMakeTranslation(0, 40+5);
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:.6 animations:^{
                    [UIView setAnimationDelay:1];
                    _newWeiboNum.transform = CGAffineTransformIdentity;
                }];
            }
        }];
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) url, &soundId);
    AudioServicesPlaySystemSound(soundId);
    
}

- (void)themeDidChange:(NSNotification *)notification{
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotification object:nil];
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    weiboLayoutArray = [[NSMutableArray alloc] init];
    [self setNavItem];
    [self getWeibo];
    [self createTable];
    [self setReFresh];
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
