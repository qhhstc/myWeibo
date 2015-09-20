//
//  CommentView.m
//  MiracleWeibo
//
//  Created by 天才邱海晖 on 15/8/28.
//  Copyright (c) 2015年 no.4. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (void)themeDidChange:(NSNotification *)notification{
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"CommentViewCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:@"commentCell"];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}
- (void)setCommentArray:(NSMutableArray *)commentArray{
    if (_commentArray != commentArray) {
        _commentArray = commentArray;
        [self reloadData];
    }
}

- (void)setWeiboFrame:(WeiboViewLayout *)weiboFrame{
    if (_weiboFrame != weiboFrame) {
        _weiboFrame = weiboFrame;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CGRect b = _weiboFrame.frame;
        return b.size.height +80;
    }
    
    if (indexPath.section == 1) {
        CommentModel *com = self.commentArray[indexPath.row];
        NSString *text = com.text;
        CGRect a = [text boundingRectWithSize:CGSizeMake(225, 900) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        return a.size.height + 80;

    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return [_commentArray count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 20;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        GettedWeibo *weibo = _weiboFrame.weiboModel;
        NSString *commentNum = [NSString stringWithFormat:@"评论：%@",weibo.commentsCount];
        return commentNum;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        GettedWeibo *weibo = self.weiboFrame.weiboModel;
        ThemeManager *manager = [ThemeManager shareThemeManager];
        UIImage *backgroundImage = [manager getThemeImage:@"/bg_home.jpg"];
        cell.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        
        weibo.userModel = [[UserModel alloc] initWithDataDic:weibo.user];
        self.userImage = [[ThemeImageView alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
        [self.userImage sd_setImageWithURL:[NSURL URLWithString:weibo.userModel.profileImage]];
        [cell.contentView addSubview:self.userImage];
        
        self.userName = [[ThemeLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userImage.frame)+8, 5, 200, 17)];
        self.userName.text = weibo.userModel.screen_name;
        self.userName.colorName = @"Timeline_Name_color";
        [cell.contentView addSubview:self.userName];
        
        self.time = [[ThemeLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userImage.frame)+8, 25, 130, 15)];
        self.time.textColor = [UIColor orangeColor];
        self.time.font = [UIFont systemFontOfSize:14];
        self.time.text = [Utils weiboDateString:weibo.createDate];
        [cell.contentView addSubview:self.time];
        
        self.from = [[ThemeLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.time.frame), 25, 250, 15)];
        self.from.font = [UIFont systemFontOfSize:14];
        NSString *regex = @">.*<";
        self.from.text = @"无无无";
        if ([weibo.source componentsMatchedByRegex:regex].count>0) {
            NSString *s = [weibo.source componentsMatchedByRegex:regex][0];
            self.from.text = [NSString stringWithFormat:@"From:%@",[s substringWithRange:NSMakeRange(1, s.length-2)]];
        }
        
        self.from.colorName = @"Timeline_Content_color";
        [cell.contentView addSubview:self.from];
        
        self.weiboView = [[WeiboView alloc] init];
        [cell.contentView addSubview:self.weiboView];
        
        [self.weiboView setWeiboLayout:self.weiboFrame];
        self.weiboView.frame = self.weiboFrame.frame;
        return cell;
    }
    
    if (indexPath.section == 1) {
        CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
        cell.comment = self.commentArray[indexPath.row];
        return cell;
    }
    return nil;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
