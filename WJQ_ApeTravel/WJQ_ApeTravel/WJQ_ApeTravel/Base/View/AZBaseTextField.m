//
//  AZBaseTextField.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/1.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseTextField.h"

@interface AZBaseTextField ()

@property (nonatomic, strong) UILabel *whiteLabel;


@end

@implementation AZBaseTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor whiteColor];
        self.clearButtonMode = UITextFieldViewModeAlways;

        self.whiteLabel = [UILabel new];
        _whiteLabel.backgroundColor = [UIColor colorWithWhite:0.960 alpha:1.000];
        [self addSubview:_whiteLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _whiteLabel.frame = CGRectMake(0, self.height - 1.5, self.width, 1.5);
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = self.font;
    
    //画出占位符
    CGRect placeholderRect;
    placeholderRect.size.width = rect.size.width;
    placeholderRect.size.height = rect.size.height;
    placeholderRect.origin.x = 0;
    placeholderRect.origin.y = (rect.size.height - self.font.lineHeight) * 0.5;
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    
    //或者
    /*
     CGPoint placeholderPoint = CGPointMake(0, (rect.size.height - self.font.lineHeight) * 0.5);
     [self.placeholder drawAtPoint:placeholderPoint withAttributes:attrs];
     */
}


@end
