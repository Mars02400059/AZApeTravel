//
//  DiscountButtonView.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/30.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "DiscountButtonView.h"

@interface DiscountButtonView ()

@property (nonatomic, strong) UIButton *myButton;

@property (nonatomic, strong) UILabel *myLabel;

@end

@implementation DiscountButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_myButton];
        
        self.myLabel = [UILabel new];
        _myLabel.textAlignment = NSTextAlignmentCenter;
        _myLabel.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:_myLabel];
    }
    return self;
}

- (void)setButtonImage:(UIImage *)buttonImage {
    _buttonImage = buttonImage;
    
    [_myButton setImage:buttonImage forState:UIControlStateNormal];
}

- (void)setButtonName:(NSString *)buttonName {
    _buttonName = buttonName;
    _myLabel.text = buttonName;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _myButton.frame = CGRectMake(0, 0, self.width, self.width);
    
    _myLabel.frame = CGRectMake(0, self.width, self.width, self.height - _myButton.height);
    
}


@end
