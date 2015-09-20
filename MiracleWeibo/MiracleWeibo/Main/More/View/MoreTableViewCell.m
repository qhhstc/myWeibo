//
//  MoreTableViewCell.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/21.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "MoreTableViewCell.h"

@implementation MoreTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[ThemeImageView alloc] initWithFrame:CGRectZero];
        _themeName = [[ThemeLabel alloc] initWithFrame:CGRectZero];
        _cellName = [[ThemeLabel alloc] initWithFrame:CGRectZero];
        [self layoutSubviews];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imgView = [[ThemeImageView alloc] initWithFrame:CGRectMake(10, 5, self.height-10, self.height-10)];
    _themeName = [[ThemeLabel alloc] initWithFrame:CGRectMake(kWidth-130, 5, 100, self.height-10)];
    _cellName = [[ThemeLabel alloc] initWithFrame:CGRectMake(_imgView.right+5, 5, kWidth-2*(_imgView.right-5), self.height-10)];
    _themeName.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_themeName];
    [self.contentView addSubview:_cellName];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
