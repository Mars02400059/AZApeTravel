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
/// 背景
@property (nonatomic, strong) UIView *backView;
/// 国家排名
@property (nonatomic, strong) UILabel *countLabel;
/// 城市或旅行地
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
        
        self.backView = [UIView new];
        _backView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_backView];
        
        
        self.countLabel = [UILabel new];
        _countLabel.textColor = [UIColor colorWithRed:1.000 green:0.614 blue:0.110 alpha:1.000];
        _countLabel.font = [UIFont systemFontOfSize:25.f];
        _countLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_countLabel];
        
        self.myLabel = [UILabel new];
        _myLabel.textColor = [UIColor colorWithRed:1.000 green:0.614 blue:0.110 alpha:1.000];
        _myLabel.font = [UIFont systemFontOfSize:18.f];
        _myLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_myLabel];
        
        

    }
    return self;
}

- (void)setPopBournModel:(FootprintPopBournModel *)popBournModel {
    _popBournModel = popBournModel;
    
    NSURL *phoneUrl = [NSURL URLWithString:popBournModel.photo];
    [_photoImageView sd_setImageWithURL:phoneUrl];
    
    _cnnameLabel.text = popBournModel.cnname;
    
    _ennameLabel.text = popBournModel.enname;
    
    _countLabel.text = [NSString stringWithFormat:@"%ld", popBournModel.count];
    
    _myLabel.text = popBournModel.label;
    
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _photoImageView.frame = self.contentView.frame;
    
    _cnnameLabel.frame = CGRectMake(10, self.contentView.height - 60, 200, 25);
    
    _ennameLabel.frame = CGRectMake(10, self.contentView.height - 30, 200, 15);
    
    _countLabel.frame = CGRectMake(self.contentView.width - 20 - 150, 20, 150, 30);
    
    _myLabel.frame = CGRectMake(self.contentView.width - 20 - 150, 50, 150, 20);
    
}

















@end
