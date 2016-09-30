//
//  HotGoodCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "HotGoodCollectionViewCell.h"

@interface HotGoodCollectionViewCell ()

@property (nonatomic, strong) UIView *myView;

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation HotGoodCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myView = [UIView new];
        _myView.layer.cornerRadius = 5.f;
        _myView.layer.borderColor = [UIColor colorWithWhite:0.662 alpha:1.000].CGColor;
        _myView.layer.borderWidth = 0.7f;
        _myView.clipsToBounds = YES;
        [self.contentView addSubview:_myView];
        
        self.photoImageView = [UIImageView new];
        [_myView addSubview:_photoImageView];
        
        self.titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 2.f;
        _titleLabel.font = [UIFont systemFontOfSize:17.f];
        [_myView addSubview:_titleLabel];
        
        self.statusLabel = [UILabel new];
        _statusLabel.font = [UIFont systemFontOfSize:14.f];
        _statusLabel.textColor = [UIColor grayColor];
        [_myView addSubview:_statusLabel];
        
        self.priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:16.f];
        _priceLabel.textColor = [UIColor orangeColor];
        [_myView addSubview:_priceLabel];
    }
    return self;
}

- (void)setHotGoodsModel:(HotGoodsModel *)hotGoodsModel {
    _hotGoodsModel = hotGoodsModel;
    
    NSURL *url = [NSURL URLWithString:hotGoodsModel.photo];
    [_photoImageView sd_setImageWithURL:url];
    
    _titleLabel.text = hotGoodsModel.title;
    
    _statusLabel.text = hotGoodsModel.status;
    
    _priceLabel.text = hotGoodsModel.price;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _myView.frame = self.contentView.bounds;
    _photoImageView.frame = CGRectMake(0, 0, _myView.width, _myView.height * 0.55);
    
    _titleLabel.frame = CGRectMake(7, _photoImageView.height, _myView.width - 7 * 2, _myView.height * 0.3);
    
    _statusLabel.frame = CGRectMake(7, _photoImageView.height + _titleLabel.height, _titleLabel.width / 2, _myView.height * 0.15);
    
    _priceLabel.frame = CGRectMake(7 + _statusLabel.width, _photoImageView.height + _titleLabel.height, _statusLabel.width, _statusLabel.height);
    
}

@end
