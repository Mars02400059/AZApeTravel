//
//  StarView.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/3.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "StarView.h"

@interface StarView ()



@end

@implementation StarView
// 重写initWithFrame：方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    if ( self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 星星的尺寸
        self.starSize = 18.0f;
        // 未点亮星星的颜色（可根据自己喜好设定）
        self.emptyColor = [UIColor colorWithWhite:0.679 alpha:1.000];
        // 点亮星星的颜色
        self.fullColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
        // 默认长度
        self.maxStar = 100.f;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _maxStar = self.width;
}

//重绘视图
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSString* stars = @"★★★★★";
    rect = self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize:_starSize];
    CGSize starSize = [stars sizeWithFont:font];
    rect.size=starSize;
    [_emptyColor set];
    [stars drawInRect:rect withFont:font];
    
    CGRect clip = rect;
    // 裁剪的宽度 = 点亮星星宽度 = （显示的星星数/总共星星数）*总星星的宽度
    clip.size.width = clip.size.width * _showStar / _maxStar;
    CGContextClipToRect(context,clip);
    [_fullColor set];
    [stars drawInRect:rect withFont:font];
}

@end
