//
//  NecessaryCollectionViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/28.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "NecessaryCollectionViewCell.h"

@interface NecessaryCollectionViewCell ()

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *soldLabel;

@property (nonatomic, strong) UILabel *priceLaebel;

@end

@implementation NecessaryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoImageView = [UIImageView new];
//        _photoImageView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_photoImageView];
        
        self.titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        
        self.soldLabel = [UILabel new];
//        _soldLabel.textColor = [UIColor grayColor];
        _soldLabel.font = [UIFont systemFontOfSize:14.f];
        [self.contentView addSubview:_soldLabel];
        
        self.priceLaebel = [UILabel new];
        
        [self.contentView addSubview:_priceLaebel];
        
        
        
    }
    return self;
}

- (void)setLocal_basicModel:(Local_BasicModel *)local_basicModel {
    _local_basicModel = local_basicModel;
    NSURL *url = [NSURL URLWithString:local_basicModel.photo];
    [_photoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"啊"]];
    
    _titleLabel.text = local_basicModel.title;
    
    _soldLabel.text = local_basicModel.sold;
    
#warning CSS数据
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[local_basicModel.price dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    // 根据想要改变的位置, 先给出一个改变位置的字符串, 比如我这里需要的是数字
    NSString *count = [NSString stringWithFormat:@"元起"];
    _priceLaebel.font = [UIFont systemFontOfSize:18.f];
    _priceLaebel.textColor = [UIColor orangeColor];
    _priceLaebel.textAlignment = NSTextAlignmentRight;
    // 给文本一个内容
    _priceLaebel.attributedText = attributedString;
    
    // 创建富文本 (可变的) NSMutableAttributedString 并把想要修改的原字符串填入
    NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:_priceLaebel.text];
    
    // 获取改变部分在原字符串中的位置
    NSRange range = [_priceLaebel.text rangeOfString:count];
    
    // 设置富文本属性(切记字典的最后一组属性, 不要有逗号)
    NSDictionary *dicA = @{
                           NSFontAttributeName:[UIFont boldSystemFontOfSize:15.f],
                           NSForegroundColorAttributeName:[UIColor grayColor]
                           };
    
    // 添加属性到相应位置
    [temp setAttributes:dicA range:range];
    
    // 将富文本给 label 的 attibutedText 属性, 这里用的是赋值符号=给予的
    _priceLaebel.attributedText = temp;

    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _photoImageView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height * 0.6);
    
    _titleLabel.frame = CGRectMake(0, _photoImageView.height, self.contentView.width, self.contentView.height * 0.25);
    
    _soldLabel.frame = CGRectMake(0, self.contentView.height * 0.75, self.contentView.width / 2, self.contentView.height * 0.25);
    
    _priceLaebel.frame = CGRectMake(self.contentView.width / 2, _soldLabel.y, _soldLabel.width, _soldLabel.height);
    
}

@end
