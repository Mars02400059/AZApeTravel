//
//  RegisterButton.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/30.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "RegisterButton.h"

@interface RegisterButton ()


@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *registerLabel;

@property (nonatomic, strong) UILabel *fansLabel;

@property (nonatomic, strong) UILabel *followLabel;

@end

@implementation RegisterButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        self.headPortraitImageView = [UIImageView new];
        _headPortraitImageView.image = [UIImage imageNamed:@"用户"];
        _headPortraitImageView.backgroundColor = [UIColor colorWithRed:0.563 green:1.000 blue:0.844 alpha:1.000];
        [self addSubview:_headPortraitImageView];
        
        self.registerLabel = [UILabel new];
        _registerLabel.textColor = [UIColor whiteColor];
        _registerLabel.font = [UIFont systemFontOfSize:19.f];
        _registerLabel.text = @"点击登录, 体验更多";
        [self addSubview:_registerLabel];
        
        CGFloat textNumber = 14.f;
        self.fansLabel = [UILabel new];
        _fansLabel.font = [UIFont systemFontOfSize:textNumber];
        _fansLabel.textColor = [UIColor whiteColor];
        _fansLabel.text = @"粉丝";
        [self addSubview:_fansLabel];
        
        self.followLabel = [UILabel new];
        _followLabel.font = [UIFont systemFontOfSize:textNumber];
        _followLabel.textColor = [UIColor whiteColor];
        _followLabel.text = @"关注";
        [self addSubview:_followLabel];
        
    }
    return self;
}

- (void)buttonAction {

    NSLog(@"哈哈");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat X = 30;
    CGFloat Y = 20;
    CGFloat X2 = 40;
    CGFloat Height = self.height - 20 * 2;
    _headPortraitImageView.frame = CGRectMake(X, Y, Height, Height);
    _headPortraitImageView.layer.cornerRadius = Height / 2;
    _headPortraitImageView.clipsToBounds = YES;
    
    
    _registerLabel.frame = CGRectMake(X2 + Height, Y + 5, self.width - X2 - Height, Height / 3);
    
    _fansLabel.frame = CGRectMake(X2 + Height, self.height - Y * 2, 30, 15);
    
    _followLabel.frame = CGRectMake(X2 + Height + _fansLabel.width + 35, self.height - Y * 2, 30, 15);
}

@end
