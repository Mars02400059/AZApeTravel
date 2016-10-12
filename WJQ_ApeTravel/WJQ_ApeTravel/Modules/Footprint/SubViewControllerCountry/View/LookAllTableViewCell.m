//
//  LookAllTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/27.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//


// 查看全部
#import "LookAllTableViewCell.h"

@interface LookAllTableViewCell ()
/**
 *  占位装饰品
 */
@property (nonatomic, strong) UILabel *grayLabel;
/**
 *  题目
 */
@property (nonatomic, strong) UILabel *myLabel;
/**
 *  按钮
 */
@property (nonatomic, strong) UIButton *myButton;

@end

@implementation LookAllTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.grayLabel = [UILabel new];
        _grayLabel.backgroundColor = [UIColor colorWithWhite:0.856 alpha:1.000];
        [self.contentView addSubview:_grayLabel];
        
        self.myLabel = [UILabel new];
        _myLabel.textColor = [UIColor colorWithWhite:0.434 alpha:1.000];
        [self.contentView addSubview:_myLabel];
        
        self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_myButton setTitleColor:[UIColor colorWithWhite:0.426 alpha:1.000] forState:UIControlStateNormal];
        [_myButton setTitle:@"查看全部>" forState:UIControlStateNormal];
        [self.contentView addSubview:_myButton];
        [_myButton addTarget:self action:@selector(myButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setLabelText:(NSString *)labelText {
    _labelText = labelText;
    _myLabel.text = labelText;
}

- (void)myButtonAction:(UIButton *)myButton {
    [self.delegate AZ_transmitInfoAndSpringCityPageTable];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _grayLabel.frame = CGRectMake(0, 0, self.contentView.width, 10);
    
    _myLabel.frame = CGRectMake(15, 10, 120, self.contentView.height - 10);
    
    _myButton.frame = CGRectMake(self.contentView.width - 120, 10, 100, self.contentView.height - 10);
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
