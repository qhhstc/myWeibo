//
//  NearbyViewController.m
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/9/1.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "NearbyViewController.h"
#import "NearbyTableViewCell.h"
#import "PostWeiboViewController.h"
@interface NearbyViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    UITableView *_tableView;
}
@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.navigationController.delegate = self;
    [self.view addSubview:_tableView];
    
    UINib *nib = [UINib nibWithNibName:@"NearbyTableViewCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"nearbyCell"];
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearbyCell" forIndexPath:indexPath];
    cell.dic = self.array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *di = _array[indexPath.row];
    NSString *text = [di valueForKey:@"address"];
    CGRect a = [text boundingRectWithSize:CGSizeMake(225, 900) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:19]} context:nil];
    return a.size.height+50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NearbyTableViewCell *cell = (NearbyTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (self.b) {
        self.b(cell.title.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_array count];
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
