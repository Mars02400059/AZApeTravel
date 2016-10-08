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

@property (nonatomic, strong) UILabel *viewsLabel;

@property (nonatomic, strong) UILabel *publish_timeLabel;

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
        _timeLabel.font = [UIFont systemFontOfSize:16.f];
        [self.contentView addSubview:_timeLabel];
        
        self.viewsLabel = [UILabel new];
        _viewsLabel.textColor = [UIColor grayColor];
        _viewsLabel.font = [UIFont systemFontOfSize:13.f];
        [self.contentView addSubview:_viewsLabel];
        
        self.publish_timeLabel = [UILabel new];
        _publish_timeLabel.textColor = [UIColor grayColor];
        _publish_timeLabel.font = [UIFont systemFontOfSize:13.f];
        [self.contentView addSubview:_publish_timeLabel];
        
        self.backLabel = [UILabel new];
        _backLabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        [self.contentView addSubview:_backLabel];
        

    }
    return self;
}


- (void)setPartnerViewModel:(PartnerViewModel *)partnerViewModel {
    _partnerViewModel = partnerViewModel;
    NSURL *url = [NSURL URLWithString:partnerViewModel.avatar];
    [_avatarImageView sd_setImageWithURL:url];
    
    _usernameLabel.text = partnerViewModel.username;
    
    _titleLabel.text = partnerViewModel.title;
    
    _timeLabel.text = [NSString stringWithFormat:@"%@ - %@  |", partnerViewModel.start_time, partnerViewModel.end_time];
    
    _publish_timeLabel.text = partnerViewModel.publish_time;
    
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
    _timeLabel.frame = CGRectMake(X, forumY, self.width / 2, Height);
    
    _viewsLabel.frame = CGRectMake(X, self.height - 60, 60, Height);
    
    _publish_timeLabel.frame = CGRectMake(self.width / 3 * 2 - 20, self.height - 60, 100, Height);
    
    _backLabel.frame = CGRectMake(0, Y + _usernameLabel.height + _titleLabel.height + 40 + Height, self.width, 10);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
