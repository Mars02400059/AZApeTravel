//
//  EnterViewCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/6.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "EnterViewCollectionViewCell.h"

@interface EnterViewCollectionViewCell ()

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *total_threadsLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UILabel *backLabel;

@end

@implementation EnterViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoImageView = [UIImageView new];
        [self.contentView addSubview:_photoImageView];
        
        self.nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:18.f];
        [self.contentView addSubview:_nameLabel];
        
        self.total_threadsLabel = [UILabel new];
        _total_threadsLabel.font = [UIFont systemFontOfSize:14.f];
        _total_threadsLabel.textAlignment = NSTextAlignmentRight;
        _total_threadsLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_total_threadsLabel];
        
        self.descriptionLabel = [UILabel new];
        _descriptionLabel.font = [UIFont systemFontOfSize:14.f];
        _descriptionLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_descriptionLabel];
        
        self.backLabel = [UILabel new];
        _backLabel.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
        [self.contentView addSubview:_backLabel];
        
    }
    return self;
}

- (void)setEnterGroupModel:(EnterGroupModel *)enterGroupModel {
    _enterGroupModel = enterGroupModel;
    NSURL *url = [NSURL URLWithString:enterGroupModel.photo];
    [_photoImageView sd_setImageWithURL:url];
    
    _nameLabel.text = enterGroupModel.name;
    
    _total_threadsLabel.text = enterGroupModel.total_threads;
    
    _descriptionLabel.text = enterGroupModel.descriptionStr;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat photoImageViewX = 15.f;
    CGFloat photoImageViewY = 15.f;
    CGFloat photoImageViewWidth = self.height - photoImageViewY * 2;
    _photoImageView.frame = CGRectMake(photoImageViewX, photoImageViewY, photoImageViewWidth, photoImageViewWidth);
    
    
    CGFloat nameX = photoImageViewX + photoImageViewWidth + 15.f;
    CGFloat nameHeight = photoImageViewWidth / 3;
    CGFloat Width = (self.width - photoImageViewWidth - photoImageViewX * 2 - 15.f) / 2;
    _nameLabel.frame = CGRectMake(nameX, photoImageViewY, Width, nameHeight);
    
    _total_threadsLabel.frame = CGRectMake(nameX + Width, photoImageViewY, Width, nameHeight);
    
    _descriptionLabel.frame = CGRectMake(nameX, photoImageViewY + nameHeight * 2, Width * 2, nameHeight);
    
    _backLabel.frame = CGRectMake(photoImageViewX, self.height - 1, self.width - photoImageViewX, 0.75);
    
}

@end
