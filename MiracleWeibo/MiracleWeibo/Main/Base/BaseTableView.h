//
//  BaseTableView.h
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/26.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface BaseTableView : UITableView

- (void)setPullString:(NSString *)str finsishString:(NSString *)finishStr getUrl:(NSString *)urlStr;

@end
