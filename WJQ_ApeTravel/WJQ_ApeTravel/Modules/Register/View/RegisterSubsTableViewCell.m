//
//  RegisterSubsTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/30.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "RegisterSubsTableViewCell.h"

@interface RegisterSubsTableViewCell ()

@property (nonatomic, strong) UILabel *backLabel;

@property (nonatomic, strong) UIImageView *myImageView;

@property (nonatomic, strong) UILabel *mylabel;

@property (nonatomic, strong) UILabel *buttonLabel;

@end

@implementation RegisterSubsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backLabel = [UILabel new];
        _backLabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        [self.contentView addSubview:_backLabel];
        
        self.myImageView = [UIImageView new];
        _myImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_myImageView];
        
        self.mylabel = [UILabel new];
        _mylabel.textColor = [UIColor grayColor];
        _mylabel.font = [UIFont systemFontOfSize:15.f];
        [self.contentView addSubview:_mylabel];
        
        self.buttonLabel = [UILabel new];
        _buttonLabel.textColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
        _buttonLabel.text = @">";
        [self.contentView addSubview:_buttonLabel];
    }
    return self;
}

- (void)setMyLabelText:(NSString *)myLabelText {
    _myLabelText = myLabelText;
    _mylabel.text = _myLabelText;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat X = 20;
    _backLabel.frame = CGRectMake(X, 0, self.contentView.width - 20, 0.5);
    
    CGFloat Y = 7;
    CGFloat Height = self.contentView.height - 7 * 2;
    _myImageView.frame = CGRectMake(X, Y, Height, Height);
    
    _mylabel.frame = CGRectMake(X + _myImageView.width + 20, Y, 200, Height);
    
    _buttonLabel.frame = CGRectMake(self.contentView.width - 20, Y, 20, Height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
