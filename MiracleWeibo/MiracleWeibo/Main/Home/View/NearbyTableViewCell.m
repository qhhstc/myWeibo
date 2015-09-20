//
//  NearbyTableViewCell.m
//  MiracleWeibo
//
//  Created by 我真的不是傻逼 on 15/9/1.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "NearbyTableViewCell.h"

@implementation NearbyTableViewCell

-(void)setDic:(NSDictionary *)dic{
    if (_dic != dic) {
        _dic = dic;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _title.text = [_dic objectForKey:@"title"];
    _address.text = [_dic objectForKey:@"address"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
