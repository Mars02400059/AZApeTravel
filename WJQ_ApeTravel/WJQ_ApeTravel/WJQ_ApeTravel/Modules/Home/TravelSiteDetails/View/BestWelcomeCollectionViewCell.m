//
//  BestWelcomeCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/28.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "BestWelcomeCollectionViewCell.h"
#import "StarView.h"



@interface BestWelcomeCollectionViewCell ()

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) StarView *starView;

@property (nonatomic, strong) UILabel *scoreLabel;

@end

@implementation BestWelcomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoImageView = [UIImageView new];
        _photoImageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_photoImageView];
        
        self.nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17.f];
        [self.contentView addSubview:_nameLabel];
        
        self.starView = [StarView new];
        [self.contentView addSubview:_starView];
        
        
        self.scoreLabel = [UILabel new];
        _scoreLabel.font = [UIFont systemFontOfSize:15.f];
        [_starView addSubview:_scoreLabel];
        // 别忘了这一步哦（关键的一步），3*20 意思是我想显示3颗星。20是没个星星的宽度（因为 上面设置了self.maxStar = 100），我的最大星星个数是5，所以每个星星的宽度是20
        
    }
    return self;
}

- (void)setMost_popularModel:(Most_PopularModel *)most_popularModel {
    _most_popularModel = most_popularModel;
    NSURL *url = [NSURL URLWithString:most_popularModel.photo];
    [_photoImageView sd_setImageWithURL:url];
    
    _nameLabel.text = most_popularModel.name;
    
    
    _starView.showStar = most_popularModel.score / 2.0f * 18;
    
    _scoreLabel.text = [NSString stringWithFormat:@"%.1f", most_popularModel.score];

    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _photoImageView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.width);
    
    _nameLabel.frame = CGRectMake(0, self.contentView.width, self.contentView.width, self.contentView.width / 4);
    
    _starView.frame = CGRectMake(0, self.contentView.height - 25, 18 * 5, 18);
    
    _scoreLabel.frame = CGRectMake(_starView.width, 2, self.width - _starView.width + 5, _starView.height);
    
    
}

@end
