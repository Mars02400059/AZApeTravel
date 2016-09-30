//
//  Hot_AreaSubViewCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "Hot_AreaSubViewCollectionViewCell.h"

@interface Hot_AreaSubViewCollectionViewCell ()

@property (nonatomic, strong) UIImageView *slideImageView;
@property (nonatomic, strong) UILabel *cityLabel;

@end

@implementation Hot_AreaSubViewCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.slideImageView = [UIImageView new];
        _slideImageView.layer.cornerRadius = 5.f;
        _slideImageView.clipsToBounds = YES;
        [self.contentView addSubview:_slideImageView];
        
        self.cityLabel = [UILabel new];
        _cityLabel.textColor = [UIColor whiteColor];
        _cityLabel.font = [UIFont systemFontOfSize:14.f];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_cityLabel];
        
    }
    return self;
}

- (void)setPlaceModel:(HotAreaPlaceModel *)placeModel {
    _placeModel = placeModel;
    NSURL *url = [NSURL URLWithString:placeModel.photo];
    [_slideImageView sd_setImageWithURL:url];
    _cityLabel.text = placeModel.name;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _slideImageView.frame = self.contentView.frame;
    _cityLabel.frame = _slideImageView.bounds;
    
    
}


@end
