//
//  TalkViewTwoImageTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "TalkViewTwoImageTableViewCell.h"

@interface TalkViewTwoImageTableViewCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *authorLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIImageView *centerImageView;

@property (nonatomic, strong) UILabel *forumLabel;

@property (nonatomic, strong) UILabel *reply_timeLabel;

@property (nonatomic, strong) UILabel *reply_numLabel;

@property (nonatomic, strong) UILabel *backLabel;

@end

@implementation TalkViewTwoImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.avatarImageView = [UIImageView new];
        _avatarImageView.clipsToBounds = YES;
        [self.contentView addSubview:_avatarImageView];
        
        self.authorLabel = [UILabel new];
        _authorLabel.font = [UIFont systemFontOfSize:14.f];
        _authorLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_authorLabel];
        
        self.titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        
        self.leftImageView = [UIImageView new];
        [self.contentView addSubview:_leftImageView];
        
        self.centerImageView = [UIImageView new];
        [self.contentView addSubview:_centerImageView];
        
        self.forumLabel = [UILabel new];
        _forumLabel.textColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
        _forumLabel.font = [UIFont systemFontOfSize:14.f];
        [self.contentView addSubview:_forumLabel];
        
        self.reply_timeLabel = [UILabel new];
        _reply_timeLabel.textColor = [UIColor grayColor];
        _reply_timeLabel.font = [UIFont systemFontOfSize:14.f];
        [self.contentView addSubview:_reply_timeLabel];
        
        self.reply_numLabel = [UILabel new];
        _reply_numLabel.textColor = [UIColor grayColor];
        _reply_numLabel.font = [UIFont systemFontOfSize:14.f];
        [self.contentView addSubview:_reply_numLabel];
        
        self.backLabel = [UILabel new];
        _backLabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        [self.contentView addSubview:_backLabel];
        
        //                _avatarImageView.backgroundColor = [UIColor cyanColor];
        //                _authorLabel.backgroundColor = [UIColor redColor];
        //                _titleLabel.backgroundColor = [UIColor yellowColor];
        //                _forumLabel.backgroundColor = [UIColor blueColor];
        //                _reply_numLabel.backgroundColor = [UIColor greenColor];
        //                _reply_timeLabel.backgroundColor = [UIColor orangeColor];
        //        _leftImageView.backgroundColor = [UIColor yellowColor];
        //        _centerImageView.backgroundColor = [UIColor redColor];
        //        _rightImageView.backgroundColor = [UIColor greenColor];
        
    }
    return self;
}

- (void)setTalkViewModel:(TalkViewModel *)talkViewModel {
    _talkViewModel = talkViewModel;
    NSURL *url = [NSURL URLWithString:talkViewModel.avatar];
    [_avatarImageView sd_setImageWithURL:url];
    
    _authorLabel.text = talkViewModel.author;
    
    _titleLabel.text = talkViewModel.title;
    
    _forumLabel.text = talkViewModel.forum;
    
    _reply_timeLabel.text = talkViewModel.reply_time;
    
    _reply_numLabel.text = [NSString stringWithFormat:@"%@", talkViewModel.reply_num];
    
    NSArray *imageUrlArray = talkViewModel.bigpic_arr;
    NSURL *leftUrl = [NSURL URLWithString:imageUrlArray[0]];
    [_leftImageView sd_setImageWithURL:leftUrl];
    
    NSURL *centerUrl = [NSURL URLWithString:imageUrlArray[1]];
    [_centerImageView sd_setImageWithURL:centerUrl];
    
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Cell 高度 25 + 35 + 55 + 50 + 10 + (self.width - X - 20 - 20 * 2) / 3;
    _avatarImageView.frame = CGRectMake(10, 25, 46, 46);
    _avatarImageView.layer.cornerRadius = 23.f;
    
    CGFloat X = 10 + 46 + 10;
    CGFloat Width = self.width - X - 20;
    CGFloat Y = 25.f;
    _authorLabel.frame = CGRectMake(X, Y, Width, 25);
    
    _titleLabel.frame = CGRectMake(X, Y + _authorLabel.height, Width, 65);
    CGFloat imageViewY = Y + _authorLabel.height + _titleLabel.height;
    CGFloat imageViewWidth = (Width - 20 * 2) / 3;
    
    _leftImageView.frame = CGRectMake(X, imageViewY, imageViewWidth, imageViewWidth);
    _centerImageView.frame = CGRectMake(X + imageViewWidth + 20, imageViewY, imageViewWidth, imageViewWidth);
    _leftImageView.layer.cornerRadius = 3.f;
    _leftImageView.clipsToBounds = YES;
    _centerImageView.layer.cornerRadius = 3.f;
    _centerImageView.clipsToBounds = YES;
    
    CGFloat forumY = Y + _authorLabel.height + _titleLabel.height + imageViewWidth;
    CGFloat Height = 50.f;
    _forumLabel.frame = CGRectMake(X, forumY, Width / 2, Height);
    
    _reply_timeLabel.frame = CGRectMake(X + Width / 5 * 3, forumY, 100, Height);
    
    _reply_numLabel.frame = CGRectMake(self.width - 20 - 30, forumY, 30, Height);
    
    _backLabel.frame = CGRectMake(0, Y + _authorLabel.height + _titleLabel.height + imageViewWidth + Height, self.width, 10);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
