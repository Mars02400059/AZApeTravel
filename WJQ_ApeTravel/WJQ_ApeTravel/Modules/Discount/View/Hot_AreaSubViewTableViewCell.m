//
//  Hot_AreaSubViewTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "Hot_AreaSubViewTableViewCell.h"

@interface Hot_AreaSubViewTableViewCell ()

@property (nonatomic, strong) UIView *myView;

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *soldLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation Hot_AreaSubViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.myView = [UIView new];
        _myView.layer.cornerRadius = 3.f;
        _myView.clipsToBounds = YES;
        _myView.layer.borderColor = [UIColor colorWithWhite:0.662 alpha:1.000].CGColor;
        _myView.layer.borderWidth = 0.5f;
        [self.contentView addSubview:_myView];
        
        self.photoImageView = [UIImageView new];
        _photoImageView.backgroundColor = [UIColor redColor];
//        _photoImageView.layer.cornerRadius = 5.f;
//        _photoImageView.clipsToBounds = YES;
        [self.myView addSubview:_photoImageView];
        
        self.titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 2;
        [self.myView addSubview:_titleLabel];
        
        self.soldLabel = [UILabel new];
        _soldLabel.textColor = [UIColor grayColor];
        _soldLabel.font = [UIFont systemFontOfSize:15.f];
        [self.myView addSubview:_soldLabel];
        
        self.priceLabel = [UILabel new];
        _priceLabel.textColor = [UIColor orangeColor];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [self.myView addSubview:_priceLabel];
        
    }
    return self;
}



- (void)setListModel:(HotAreaListModel *)listModel {
    _listModel = listModel;
    NSURL *url = [NSURL URLWithString:listModel.photo];
    [_photoImageView sd_setImageWithURL:url];
    
    _titleLabel.text = listModel.title;
    _soldLabel.text = listModel.sold;
    _priceLabel.text = [NSString stringWithFormat:@"%@元起",listModel.price];
}
- (void)setTopicListModel:(DiscountTopicListModel *)topicListModel {
    _topicListModel = topicListModel;
    
    NSURL *url = [NSURL URLWithString:topicListModel.photo];
    [_photoImageView sd_setImageWithURL:url];
    
    _titleLabel.text = topicListModel.title;
    
    _soldLabel.text = topicListModel.sold;
    
    _priceLabel.text = [NSString stringWithFormat:@"%@元起",topicListModel.price];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // tableViewCell高度  
    
    CGFloat Width = self.contentView.width;
    CGFloat Height = self.contentView.height - 15 * 2;
    
    _myView.frame = CGRectMake(0, 15, Width, Height);
    
    _photoImageView.frame = CGRectMake(0, 0, Height * 0.8, Height);
    
    _titleLabel.frame = CGRectMake(_photoImageView.width + 10, 3, Width - _photoImageView.width - 10 * 2, Height / 2);
    
    _soldLabel.frame = CGRectMake(_photoImageView.width + 10, Height / 4 * 3 - 3, _titleLabel.width / 2, Height / 4);
    
    _priceLabel.frame = CGRectMake(_photoImageView.width + 10 + _soldLabel.width, Height / 4 * 3 - 3, _soldLabel.width, _soldLabel.height);
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
