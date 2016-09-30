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
        _photoImageView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_photoImageView];
        
        self.titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        
        self.soldLabel = [UILabel new];
        _soldLabel.textColor = [UIColor grayColor];
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
    [_photoImageView sd_setImageWithURL:url];
    
    _titleLabel.text = local_basicModel.title;
    
    _soldLabel.text = local_basicModel.sold;
    
#warning CSS数据
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[local_basicModel.price dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _priceLaebel.attributedText = attributedString;
    _priceLaebel.font = [UIFont systemFontOfSize:15.f];
    _priceLaebel.textColor = [UIColor orangeColor];
    _priceLaebel.textAlignment = NSTextAlignmentRight;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _photoImageView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height * 0.6);
    
    _titleLabel.frame = CGRectMake(0, _photoImageView.height, self.contentView.width, self.contentView.height * 0.25);
    
    _soldLabel.frame = CGRectMake(0, self.contentView.height * 0.75, self.contentView.width / 2, self.contentView.height * 0.25);
    
    _priceLaebel.frame = CGRectMake(self.contentView.width / 2, _soldLabel.y, _soldLabel.width, _soldLabel.height);
    
}

@end
