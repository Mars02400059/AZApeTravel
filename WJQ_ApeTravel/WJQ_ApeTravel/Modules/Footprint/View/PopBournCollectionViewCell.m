//
//  PopBournCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "PopBournCollectionViewCell.h"
#import "FootprintPopBournModel.h"

@interface PopBournCollectionViewCell ()

/// 国家图片
@property (nonatomic, strong) UIImageView *photoImageView;
/// 国家名字
@property (nonatomic, strong) UILabel *cnnameLabel;
/// 国家英文名
@property (nonatomic, strong) UILabel *ennameLabel;
/// 国家排名
@property (nonatomic, strong) UILabel *countLabel;
/// 城市
@property (nonatomic, strong) UILabel *myLabel;

@end

@implementation PopBournCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoImageView = [UIImageView new];
        _photoImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_photoImageView];
        
        self.cnnameLabel = [UILabel new];
        _cnnameLabel.textColor = [UIColor whiteColor];
        _cnnameLabel.font = [UIFont systemFontOfSize:22.f];
        [self.contentView addSubview:_cnnameLabel];
        
        self.ennameLabel = [UILabel new];
        _ennameLabel.textColor = [UIColor whiteColor];
        _ennameLabel.font = [UIFont systemFontOfSize:15.f];
        [self.contentView addSubview:_ennameLabel];

    }
    return self;
}

- (void)setPopBournModel:(FootprintPopBournModel *)popBournModel {
    _popBournModel = popBournModel;
    
    NSURL *phoneUrl = [NSURL URLWithString:popBournModel.photo];
    [_photoImageView sd_setImageWithURL:phoneUrl];
    
    _cnnameLabel.text = popBournModel.cnname;
    
    _ennameLabel.text = popBournModel.enname;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _photoImageView.frame = self.contentView.frame;
    
    _cnnameLabel.frame = CGRectMake(10, self.contentView.height - 60, 200, 25);
    
    _ennameLabel.frame = CGRectMake(10, self.contentView.height - 30, 200, 15);
}

















@end
