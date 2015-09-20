//
//  NearbyTableViewCell.h
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/9/1.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearbyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property(nonatomic,strong) NSDictionary *dic;
@end
