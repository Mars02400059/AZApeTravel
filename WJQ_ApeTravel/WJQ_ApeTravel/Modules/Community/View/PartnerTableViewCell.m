//
//  PartnerTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "PartnerTableViewCell.h"

@interface PartnerTableViewCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *cityLabel;

@property (nonatomic, strong) UILabel *viewsLabel;

@property (nonatomic, strong) UILabel *publish_timeLabel;

@property (nonatomic, strong) UILabel *replysLabel;

@property (nonatomic, strong) UILabel *backLabel;

@end

@implementation PartnerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.avatarImageView = [UIImageView new];
        _avatarImageView.clipsToBounds = YES;
        [self.contentView addSubview:_avatarImageView];
        
        self.usernameLabel = [UILabel new];
        _usernameLabel.textColor = [UIColor grayColor];
        _usernameLabel.font = [UIFont systemFontOfSize:14.f];
        [self.contentView addSubview:_usernameLabel];
        
        self.titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        
        self.timeLabel = [UILabel new];
        _timeLabel.textColor = [UIColor colorWithWhite:0.626 alpha:1.000];
        _timeLabel.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_timeLabel];
        
        self.cityLabel = [UILabel new];
        _cityLabel.textColor = [UIColor colorWithWhite:0.626 alpha:1.000];
        _cityLabel.font = [UIFont systemFontOfSize:13.f];
        [_timeLabel addSubview:_cityLabel];
        
        self.viewsLabel = [UILabel new];
        _viewsLabel.textColor = [UIColor grayColor];
        _viewsLabel.font = [UIFont systemFontOfSize:13.f];
        [self.contentView addSubview:_viewsLabel];
        
        self.publish_timeLabel = [UILabel new];
        _publish_timeLabel.textColor = [UIColor grayColor];
        _publish_timeLabel.font = [UIFont systemFontOfSize:13.f];
        [self.contentView addSubview:_publish_timeLabel];
        
        self.replysLabel = [UILabel new];
        _replysLabel.textColor = [UIColor grayColor];
        _replysLabel.font = [UIFont systemFontOfSize:13.f];
        [self.contentView addSubview:_replysLabel];
        

        
        self.backLabel = [UILabel new];
        _backLabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        [self.contentView addSubview:_backLabel];
        

    }
    return self;
}


- (void)setPartnerViewModel:(PartnerViewModel *)partnerViewModel {
    _partnerViewModel = partnerViewModel;
    NSURL *url = [NSURL URLWithString:partnerViewModel.avatar];
//    [_avatarImageView sd_setImageWithURL:url];
    [_avatarImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认图片"]];
    _usernameLabel.text = partnerViewModel.username;
    
    _titleLabel.text = partnerViewModel.title;
    
    _timeLabel.text = [NSString stringWithFormat:@"    %@-%@  |", partnerViewModel.start_time, partnerViewModel.end_time];
    
    _cityLabel.text = partnerViewModel.citys_str;
    
    _publish_timeLabel.text = partnerViewModel.publish_time;
    
    _replysLabel.text = [NSString stringWithFormat:@" %@", partnerViewModel.replys];
    
    _viewsLabel.text = [NSString stringWithFormat:@"%@人浏览", partnerViewModel.views];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // Cell 高度 25 + 25 + 45 + 50 + 50;
    _avatarImageView.frame = CGRectMake(10, 25, 46, 46);
    _avatarImageView.layer.cornerRadius = 23.f;
    
    CGFloat X = 10 + 46 + 10;
    CGFloat Width = self.width - X - 20;
    CGFloat Y = 25.f;
    _usernameLabel.frame = CGRectMake(X, Y, Width, 25);
    
    _titleLabel.frame = CGRectMake(X, Y + _usernameLabel.height, Width, 45);
    CGFloat forumY = Y + _usernameLabel.height + _titleLabel.height;
    CGFloat Height = 50.f;
    _timeLabel.frame = CGRectMake(X, forumY, 170, Height);
    UIImageView *rili = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"日历"]];
    rili.frame = CGRectMake(-2, 18, 14, 14);
    [_timeLabel addSubview:rili];
    UIImageView *dingwei = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"定位"]];
    dingwei.frame = CGRectMake(_timeLabel.width, 18, 14, 14);
    [_timeLabel addSubview:dingwei];

    _cityLabel.frame = CGRectMake(_timeLabel.width + dingwei.width + 5, 0, 100, _timeLabel.height);
    
    _viewsLabel.frame = CGRectMake(X, self.height - 60, 60, Height);
    
    _publish_timeLabel.frame = CGRectMake(self.width / 3 * 2 - 20, self.height - 60, 100, Height);
    
    UIImageView *shijian = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"手表"]];
    shijian.frame = CGRectMake(-16, 18, 14, 14);
    [_publish_timeLabel addSubview:shijian];
    
    _replysLabel.frame = CGRectMake(self.width - 40, self.height - 60, 40, Height);
    
    UIImageView *xiaoxi  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"消息"]];
    xiaoxi.frame = CGRectMake(-16, 18, 14, 14);
    [_replysLabel addSubview:xiaoxi];
    
    _backLabel.frame = CGRectMake(0, Y + _usernameLabel.height + _titleLabel.height + 40 + Height, self.width, 10);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
