//
//  TravelInspanTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/26.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "TravelInspanTableViewCell.h"
#import "TravelInspanModel.h"

@interface TravelInspanTableViewCell ()

/**
 *  分割线
 */
@property (nonatomic, strong) UILabel *label;
/**
 *  图片
 */
@property (nonatomic, strong) UIImageView *photoImageView;
/**
 *  标题
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 *  打折
 */
@property (nonatomic, strong) UILabel *priceoffLabel;
/**
 *  起价
 */
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation TravelInspanTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [UILabel new];
        _label.backgroundColor = [UIColor colorWithWhite:0.734 alpha:1.000];
        [self.contentView addSubview:_label];
        
        self.photoImageView = [UIImageView new];
        [self.contentView addSubview:_photoImageView];
        
        self.titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        
        self.priceoffLabel = [UILabel new];
        _priceoffLabel.font = [UIFont systemFontOfSize:13.f];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceoffLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_priceoffLabel];
        
        self.priceLabel = [UILabel new];
        [self.contentView addSubview:_priceLabel];
        
        
    }
    return self;
}

- (void)setTravelInspanModel:(TravelInspanModel *)travelInspanModel {
    _travelInspanModel = travelInspanModel;

    
    NSURL *url = [NSURL URLWithString:travelInspanModel.photo];
    [_photoImageView sd_setImageWithURL:url];
    
    _titleLabel.text = travelInspanModel.title;
    
    _priceoffLabel.text = travelInspanModel.priceoff;
    
#warning CSS数据
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[travelInspanModel.price dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _priceLabel.attributedText = attributedString;
    _priceLabel.textColor = [UIColor colorWithRed:1.000 green:0.562 blue:0.218 alpha:1.000];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.font = [UIFont systemFontOfSize:15.f];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat X = 15.f;
    _label.frame = CGRectMake(X, 1, self.contentView.width - X, 1);
    
    CGFloat photoHeight = self.contentView.height - 10 * 2;
    _photoImageView.frame = CGRectMake(X, 10, photoHeight * 1.6, photoHeight);
    
    CGFloat labelX = 15 + 15 + photoHeight * 1.6;
    _titleLabel.frame = CGRectMake(labelX, 10, self.contentView.width - labelX - 15, photoHeight * 4 / 7);
    
    _priceoffLabel.frame = CGRectMake(labelX, 10 + photoHeight * 5 / 7, 70, photoHeight * 2 / 7);
    
    _priceLabel.frame = CGRectMake(self.contentView.width - 120, 10 + photoHeight * 4 / 7, 100, 10 + photoHeight * 3 / 7);

    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
