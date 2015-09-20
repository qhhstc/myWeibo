//
//  BaseTableView.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/26.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView
- (void)setPullString:(NSString *)str finsishString:(NSString *)finishStr getUrl:(NSString *)urlStr{
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.header = header;
    
    [header beginRefreshing];
    [header setTitle:@"喂卢卡吃屎" forState:MJRefreshStateIdle];
    [header setTitle:@"卢卡快吃饱了" forState:MJRefreshStatePulling];
    [header setTitle:@"卢卡吃饱了" forState:MJRefreshStateRefreshing];
}

- (void)headerRereshing
{
    //一般这些个里边是网络请求，然后会有延迟，不会像现在刷新这么快
    // 1.添加数据
    [self reloadData];
    //2.结束刷新
    [self.header endRefreshing];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
