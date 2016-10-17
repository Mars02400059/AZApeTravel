//
//  TypeSubsCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/11.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "TypeSubsCollectionViewCell.h"

@interface TypeSubsCollectionViewCell ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TypeSubsCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5.f;
        _backView.layer.borderColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000].CGColor;
        _backView.layer.borderWidth = 1.f;
        _backView.clipsToBounds = YES;
        [self.contentView addSubview:_backView];
        
        self.titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_backView addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setPoiModel:(DiscountTypeDataPoiModel *)poiModel {

    _poiModel = poiModel;
    
    _titleLabel.text = poiModel.cityName;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backView.frame = self.contentView.bounds;
    _titleLabel.frame = _backView.bounds;
}

@end
