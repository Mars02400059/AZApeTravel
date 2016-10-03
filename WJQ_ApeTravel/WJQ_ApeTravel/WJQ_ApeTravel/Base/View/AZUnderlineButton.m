//
//  AZUnderlineButton.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/1.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZUnderlineButton.h"

@interface AZUnderlineButton ()

@property (nonatomic, strong) UILabel *underlineLaebl;

@end

@implementation AZUnderlineButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.underlineLaebl = [UILabel new];
        _underlineLaebl.backgroundColor = [UIColor colorWithWhite:0.794 alpha:1.000];
        [self addSubview:_underlineLaebl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _underlineLaebl.frame = CGRectMake(0, self.height - 0.7, self.width, 0.7);
}

@end
