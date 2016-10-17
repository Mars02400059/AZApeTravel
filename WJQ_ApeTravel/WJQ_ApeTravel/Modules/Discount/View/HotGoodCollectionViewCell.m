//
//  HotGoodCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "HotGoodCollectionViewCell.h"

@interface HotGoodCollectionViewCell ()

@property (nonatomic, strong) UIView *myView;

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation HotGoodCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myView = [UIView new];
        _myView.layer.cornerRadius = 5.f;
        _myView.layer.borderColor = [UIColor colorWithWhite:0.662 alpha:1.000].CGColor;
        _myView.layer.borderWidth = 0.7f;
        _myView.clipsToBounds = YES;
        [self.contentView addSubview:_myView];
        
        self.photoImageView = [UIImageView new];
        [_myView addSubview:_photoImageView];
        
        self.titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 2.f;
        _titleLabel.font = [UIFont systemFontOfSize:17.f];
        [_myView addSubview:_titleLabel];
        
        self.statusLabel = [UILabel new];
        _statusLabel.font = [UIFont systemFontOfSize:14.f];
        _statusLabel.textColor = [UIColor grayColor];
        [_myView addSubview:_statusLabel];
        
        self.priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:15.f];
        _priceLabel.textColor = [UIColor grayColor];
        [_myView addSubview:_priceLabel];
    }
    return self;
}

- (void)setHotGoodsModel:(HotGoodsModel *)hotGoodsModel {
    _hotGoodsModel = hotGoodsModel;
    
    NSURL *url = [NSURL URLWithString:hotGoodsModel.photo];
    [_photoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"啊"]];
    
    _titleLabel.text = hotGoodsModel.title;
    
    _statusLabel.text = hotGoodsModel.status;
    
    // 根据想要改变的位置, 先给出一个改变位置的字符串, 比如我这里需要的是数字
    NSString *count = hotGoodsModel.price;
    
    // 给文本一个内容
    _priceLabel.text = [NSString stringWithFormat:@"%@元起", count];
    
    // 创建富文本 (可变的) NSMutableAttributedString 并把想要修改的原字符串填入
    NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:_priceLabel.text];
    
    // 获取改变部分在原字符串中的位置
    NSRange range = [_priceLabel.text rangeOfString:count];
    
    // 设置富文本属性(切记字典的最后一组属性, 不要有逗号)
    NSDictionary *dicA = @{
                           NSFontAttributeName:[UIFont boldSystemFontOfSize:18.f],
                           NSForegroundColorAttributeName:[UIColor orangeColor]
                           };
    
    // 添加属性到相应位置
    [temp setAttributes:dicA range:range];
    
    // 将富文本给 label 的 attibutedText 属性, 这里用的是赋值符号=给予的
    _priceLabel.attributedText = temp;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _myView.frame = self.contentView.bounds;
    _photoImageView.frame = CGRectMake(0, 0, _myView.width, _myView.height * 0.55);
    
    _titleLabel.frame = CGRectMake(7, _photoImageView.height, _myView.width - 7 * 2, _myView.height * 0.3);
    
    _statusLabel.frame = CGRectMake(7, _photoImageView.height + _titleLabel.height, _titleLabel.width / 2, _myView.height * 0.15);
    
    _priceLabel.frame = CGRectMake(_statusLabel.width - 3, _photoImageView.height + _titleLabel.height, _statusLabel.width + 10, _statusLabel.height);
    
}

@end
