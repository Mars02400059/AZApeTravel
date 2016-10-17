//
//  TypeCityTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/12.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "TypeCityTableViewCell.h"

@interface TypeCityTableViewCell ()

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *soldLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation TypeCityTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.photoImageView = [UIImageView new];
        [self.contentView addSubview:_photoImageView];
        
        self.titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.numberOfLines = 2.f;
        [self.contentView addSubview:_titleLabel];
        
        self.soldLabel = [UILabel new];
        _soldLabel.font = [UIFont systemFontOfSize:14.f];
        _soldLabel.textColor = [UIColor colorWithWhite:0.607 alpha:1.000];
        [self.contentView addSubview:_soldLabel];
        
        self.priceLabel = [UILabel new];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont systemFontOfSize:15.f];
        [self.contentView addSubview:_priceLabel];
    }
    return self;

}


- (void)setListModel:(DiscountCityListModel *)listModel {
    
    _listModel = listModel;
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:listModel.photo] placeholderImage:[UIImage imageNamed:@"啊"]];
    
    _titleLabel.text = listModel.title;
    
    _soldLabel.text = listModel.sold;
    
    // 给文本一个内容
    _priceLabel.text = [NSString stringWithFormat:@"%@元起", listModel.price];
    
    // 创建富文本 (可变的) NSMutableAttributedString 并把想要修改的原字符串填入
    NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:_priceLabel.text];
    
    // 获取改变部分在原字符串中的位置
    NSRange range = [_priceLabel.text rangeOfString:listModel.price];
    
    // 设置富文本属性(切记字典的最后一组属性, 不要有逗号)
    NSDictionary *dicA = @{
                           NSFontAttributeName:[UIFont boldSystemFontOfSize:19.f],
                           NSForegroundColorAttributeName:[UIColor orangeColor]
                           };
    
    // 添加属性到相应位置
    [temp setAttributes:dicA range:range];
    
    // 将富文本给 label 的 attibutedText 属性, 这里用的是赋值符号=给予的
    _priceLabel.attributedText = temp;
    

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 高度 10 * 2 +
    
    CGFloat X = 20.f;
    CGFloat Y = 10.f;
    CGFloat Width = self.contentView.width - X * 2;
    CGFloat Height = self.contentView.height - Y * 2;
    
    _photoImageView.frame = CGRectMake(X, Y, Height * 1.2, Height);
    
    _titleLabel.frame = CGRectMake(X + _photoImageView.width + 10, Y, Width - 10 - _photoImageView.width, Height / 2);
    CGFloat soldY = self.contentView.height - 40.f;
    _soldLabel.frame = CGRectMake(_titleLabel.x, soldY, (Width - _photoImageView.width) / 5 * 2, 20);
    
    _priceLabel.frame = CGRectMake(self.contentView.width - 120, _soldLabel.y, 100, _soldLabel.height);

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
