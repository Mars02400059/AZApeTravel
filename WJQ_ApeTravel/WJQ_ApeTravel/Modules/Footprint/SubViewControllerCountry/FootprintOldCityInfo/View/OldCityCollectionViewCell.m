//
//  OldCityCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "OldCityCollectionViewCell.h"

@interface OldCityCollectionViewCell ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) UILabel *catenameLabel;

@property (nonatomic, strong) UILabel *catename_enLabel;

@property (nonatomic, strong) UILabel *beenstrLabel;

@property (nonatomic, strong) UILabel *representativeLabel;

@end

@implementation OldCityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [UIView new];
        _backView.layer.borderColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00].CGColor;
        _backView.layer.borderWidth = 0.5f;
//        _backView.layer.cornerRadius = 4.f;
        _backView.clipsToBounds = YES;
        [self.contentView addSubview:_backView];
        
        self.photoImageView = [UIImageView new];
        [_backView addSubview:_photoImageView];
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _effectView.alpha = 0.4f;
        [_photoImageView addSubview:_effectView];
        
        self.catenameLabel = [UILabel new];
        _catenameLabel.font = [UIFont systemFontOfSize:18.f];
        _catenameLabel.textColor = [UIColor whiteColor];
        _catenameLabel.textAlignment = NSTextAlignmentCenter;
        [_photoImageView addSubview:_catenameLabel];
        
        self.catename_enLabel = [UILabel new];
        _catename_enLabel.font = [UIFont systemFontOfSize:14.f];
        _catename_enLabel.textColor = [UIColor whiteColor];
        _catename_enLabel.textAlignment = NSTextAlignmentCenter;
        [_photoImageView addSubview:_catename_enLabel];
        
        self.beenstrLabel = [UILabel new];
        _beenstrLabel.font = [UIFont systemFontOfSize:13.f];
        _beenstrLabel.textColor = [UIColor grayColor];
        [_backView addSubview:_beenstrLabel];
        
        self.representativeLabel = [UILabel new];
        _representativeLabel.textColor = [UIColor grayColor];
        _representativeLabel.font = [UIFont systemFontOfSize:15.f];
        _representativeLabel.numberOfLines = 2.f;
        [_backView addSubview:_representativeLabel];
        
        
    }
    return self;
}

- (void)setOldCityModel:(OldCityModel *)oldCityModel {
    _oldCityModel = oldCityModel;
    NSURL *url = [NSURL URLWithString:oldCityModel.photo];
    [_photoImageView sd_setImageWithURL:url];
    
    _catenameLabel.text = oldCityModel.catename;
    
    _catename_enLabel.text = oldCityModel.catename_en;
    
    _beenstrLabel.text = oldCityModel.beenstr;
    
    _representativeLabel.text = oldCityModel.representative;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backView.frame = self.bounds;
    
    _photoImageView.frame = CGRectMake(0, 0, _backView.width, _backView.width * 0.7);
    _effectView.frame = _photoImageView.bounds;

    
    _catenameLabel.frame = CGRectMake(0, 0, _photoImageView.width, 30);
    _catenameLabel.center = CGPointMake(_photoImageView.center.x, _photoImageView.center.y - 15);

    _catename_enLabel.frame = CGRectMake(0, 0, _photoImageView.width, 20);
    _catename_enLabel.center = CGPointMake(_photoImageView.center.x, _photoImageView.center.y + 5);
    
    _beenstrLabel.frame = CGRectMake(10, _photoImageView.height, _backView.width - 10 * 2, _backView.width * 0.15);
    
    _representativeLabel.frame = CGRectMake(10, _photoImageView.height + _beenstrLabel.height, _backView.width - 10 * 2, _backView.width * 0.35);
    
    
    
}

@end
