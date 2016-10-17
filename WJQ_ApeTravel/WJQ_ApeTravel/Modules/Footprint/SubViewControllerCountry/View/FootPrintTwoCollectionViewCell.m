//
//  FootPrintTwoCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/27.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//


/**
 *  cell中collectionView
 */
#import "FootPrintTwoCollectionViewCell.h"
#import "CityModel.h"

@interface FootPrintTwoCollectionViewCell ()
/**
 *  <#Description#>
 */
@property (nonatomic, strong) UIImageView *slideImageView;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *cityEnglishLabel;

@end

@implementation FootPrintTwoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.slideImageView = [UIImageView new];
        [self.contentView addSubview:_slideImageView];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _effectView.alpha = 0.4f;
        [_slideImageView addSubview:_effectView];
        
        
        self.cityLabel = [UILabel new];
        _cityLabel.textColor = [UIColor whiteColor];
        _cityLabel.font = [UIFont systemFontOfSize:22.f];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_cityLabel];
        
        self.cityEnglishLabel = [UILabel new];
        _cityEnglishLabel.textColor = [UIColor whiteColor];
        _cityEnglishLabel.font = [UIFont systemFontOfSize:15.f];
        _cityEnglishLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_cityEnglishLabel];
        
    }
    return self;
}

- (void)setCityModel:(CityModel *)cityModel {
    _cityModel = cityModel;
    NSURL *url = [NSURL URLWithString:cityModel.photo];
//    [_slideImageView sd_setImageWithURL:url];
    [_slideImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"啊"]];
    
    _cityLabel.text = cityModel.cnname;
    
    _cityEnglishLabel.text = cityModel.enname;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _slideImageView.frame = self.contentView.frame;
    _cityLabel.frame = CGRectMake(0, self.contentView.height / 3, self.contentView.width, 30);
    _effectView.frame = _slideImageView.bounds;

    _cityEnglishLabel.frame = CGRectMake(0, self.contentView.height / 5 * 3, self.contentView.width, 17);
    
}

@end
