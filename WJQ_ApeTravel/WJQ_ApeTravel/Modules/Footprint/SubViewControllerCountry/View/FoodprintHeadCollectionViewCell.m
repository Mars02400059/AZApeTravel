//
//  FoodprintHeadCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/27.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

/**
 *  头视图轮播图
 */

#import "FoodprintHeadCollectionViewCell.h"

@interface FoodprintHeadCollectionViewCell ()
/**
 *  轮播图图片
 */
@property (nonatomic, strong) UIImageView *slideImageView;

@end

@implementation FoodprintHeadCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.slideImageView = [UIImageView new];
        [self.contentView addSubview:_slideImageView];
        
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    NSURL *url = [NSURL URLWithString:imageName];
    [_slideImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"啊"]];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _slideImageView.frame = self.contentView.frame;
}


@end
