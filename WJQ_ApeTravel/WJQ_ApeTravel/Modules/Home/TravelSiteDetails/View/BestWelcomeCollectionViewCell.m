//
//  BestWelcomeCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/28.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "BestWelcomeCollectionViewCell.h"

@interface BestWelcomeCollectionViewCell ()

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel *nameLabel;


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
        
    }
    return self;
}

- (void)setMost_popularModel:(Most_PopularModel *)most_popularModel {
    _most_popularModel = most_popularModel;
    NSURL *url = [NSURL URLWithString:most_popularModel.photo];
    [_photoImageView sd_setImageWithURL:url];
    
    _nameLabel.text = most_popularModel.name;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _photoImageView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.width);
    
    _nameLabel.frame = CGRectMake(0, self.contentView.width, self.contentView.width, self.contentView.width / 4);
    
    
    
    
}

@end
