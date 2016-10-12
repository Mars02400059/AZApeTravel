//
//  NOMissSubsTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/28.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "NOMissSubsTableViewCell.h"

@interface NOMissSubsTableViewCell ()

@property (nonatomic, strong) UIImageView *pic_urlImageView;

@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UILabel *backLabel;

@end

@implementation NOMissSubsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.backLabel = [UILabel new];
//        _backLabel.backgroundColor = [UIColor colorWithWhite:0.636 alpha:1.000];
//        [self.contentView addSubview:_backLabel];
        
        self.pic_urlImageView = [UIImageView new];
        [self.contentView addSubview:_pic_urlImageView];
        // 设置模糊效果
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _effectView.alpha = 0.4f;
        [_pic_urlImageView addSubview:_effectView];
        
        
        self.nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:22.f];
        [self.contentView addSubview:_nameLabel];
        
        
        self.descLabel = [UILabel new];
        _descLabel.textColor = [UIColor grayColor];
        _descLabel.numberOfLines= 2;
        _descLabel.font = [UIFont systemFontOfSize:15.f];
        [self.contentView addSubview:_descLabel];
        
        
    }
    return self;
}

- (void)setNot_missModel:(Not_MissModel *)not_missModel {
    _not_missModel = not_missModel;
    NSURL *url = [NSURL URLWithString:not_missModel.pic_url];
    [_pic_urlImageView sd_setImageWithURL:url];
    
    _nameLabel.text = not_missModel.name;
    
    _descLabel.text = not_missModel.desc;
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 总高度  self.contentView.width * 0.5 + 70

//    _backLabel.frame = CGRectMake(0, 0, self.contentView.width, 10);
    _pic_urlImageView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.width * 0.5);
    _effectView.frame = _pic_urlImageView.bounds;

    
    
    _nameLabel.frame = CGRectMake(0, (_pic_urlImageView.height -  30) / 2, self.contentView.width, 30);
    
    _descLabel.frame = CGRectMake(25, _pic_urlImageView.height, self.contentView.width - 25 * 2, 70);
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
