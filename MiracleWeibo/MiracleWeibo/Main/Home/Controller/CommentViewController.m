//
//  CommentViewController.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/28.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    //[self createBar];
    [self createComment];
    // Do any additional setup after loading the view.
}

//- (void)createBar{
//    GettedWeibo *weibo = self.weiboFrame.weiboModel;
//    NSNumber *commentNum = weibo.commentsCount;
//    NSNumber *reposts = weibo.repostsCount;
//    NSNumber *likeNum = weibo.favorited;
//    self.barView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , kWidth, 40)];
//    self.barView.backgroundColor = [UIColor whiteColor];
//    UIButton *comment = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 100, 40)];
//    UIButton *repost = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 100, 40)];
//    UIButton *like = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-100, 0, 100, 40)];
//    comment.titleLabel.text = [NSString stringWithFormat:@"Comment %li",[commentNum integerValue]];
//    repost.titleLabel.text = [NSString stringWithFormat:@"Repost %li",[reposts integerValue]];
//    repost.titleLabel.textColor = [UIColor grayColor];
//    like.titleLabel.text = [NSString stringWithFormat:@"Like %li",[likeNum integerValue]];
//    like.titleLabel.textColor = [UIColor grayColor];
//    
//    [self.barView addSubview:comment];
//    [self.barView addSubview:repost];
//    [self.barView addSubview:like];
//    [self.view addSubview:self.barView];
//}
- (SinaWeibo *)sinaweibo
{
    AppDelegate* delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;

}


- (void)createComment{
    GettedWeibo *weibo = self.weiboFrame.weiboModel;
    SinaWeibo *sinaWeibo = [self sinaweibo];
    sinaWeibo.delegate = self;
    NSDictionary *params = @{@"id":weibo.weiboId.stringValue,
                             @"count":@"20"
                             };
    SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"https://api.weibo.com/2/comments/show.json" params:[params mutableCopy] httpMethod:@"GET" delegate:self];
    request.tag = 200;
    [self showHUD:@"正在加载"];
    
    self.commentTable = [[CommentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.barView.frame), kWidth, kHeight-64) style:UITableViewStyleGrouped];
    [self setRefresh];
    self.commentTable.weiboFrame = self.weiboFrame;
    [self.view addSubview:self.commentTable];
}

#pragma -mark MJRefresh

- (void)setRefresh{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    self.commentTable.footer = footer;
    
    [footer setTitle:@"你看啥" forState:MJRefreshStateIdle];
    [footer setTitle:@"有啥好看" forState:MJRefreshStatePulling];
    [footer setTitle:@"你再看" forState:MJRefreshStateRefreshing];
}

- (void)footerRefreshing{
    GettedWeibo *weibo = self.weiboFrame.weiboModel;
    SinaWeibo *sinaWeibo = [self sinaweibo];
    sinaWeibo.delegate = self;
    if (self.commentTable.commentArray > 0) {
        CommentModel *lastComment = [self.commentTable.commentArray lastObject];
        NSString *maxID = lastComment.maxId.stringValue;
        NSLog(@"%@",maxID);
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:maxID forKey:@"max_id"];
        [params setObject:weibo.weiboId.stringValue forKey:@"id"];
        [params setObject:@"10" forKey:@"count"];
        SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"https://api.weibo.com/2/comments/show.json" params:params httpMethod:@"GET" delegate:self];
        request.tag = 201;
    }
    [self.commentTable.footer endRefreshing];

}


- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    NSArray *array = [(NSDictionary *)result objectForKey:@"comments"];
    NSMutableArray *a = [[NSMutableArray alloc] init];
    for (NSDictionary *weiDic in array) {
        CommentModel *comment = [[CommentModel alloc] initWithDataDic:weiDic];
        [a addObject:comment];
    }
    if (a.count > 0) {
        if (request.tag == 200) {
            self.commentTable.commentArray = a;
            [self completeHUD:@"完成加载"];
        }
        if (request.tag == 201) {
            [a removeObjectAtIndex:0];
            [self.commentTable.commentArray addObjectsFromArray:a];
            [self.commentTable reloadData];
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
