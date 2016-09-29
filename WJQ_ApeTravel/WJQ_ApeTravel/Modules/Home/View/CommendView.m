//
//  CommendView.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "CommendView.h"
#import "TabView.h"



@interface CommendView ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *city_nameLabel;

@end

@implementation CommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self createSubView];
       
        
        
    }
    return self;
}

- (void)createSubView {
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width / 3 + 10)];
    _coverImageView.userInteractionEnabled = YES;
    [self addSubview:_coverImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    // 设置需要轻拍的次数
    tap.numberOfTapsRequired = 1;
    
    // 视图添加一个手势
    [_coverImageView addGestureRecognizer:tap];

    
    // 添加模糊效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.alpha = 0.35f;
    [_coverImageView addSubview:effectView];
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.height = 20.f;
    _titleLabel.width = 60.f;
    _titleLabel.font = [UIFont systemFontOfSize:15.f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.center = CGPointMake(_coverImageView.bounds.size.width / 2, 25);
    _titleLabel.textColor = [UIColor colorWithWhite:0.693 alpha:1.000];
    effectView.frame = _coverImageView.frame;
    [_coverImageView addSubview:_titleLabel];
    
    self.city_nameLabel = [[UILabel alloc] init];
    _city_nameLabel.width = 120.f;
    _city_nameLabel.height = 40.f;
    _city_nameLabel.textColor = [UIColor whiteColor];
    _city_nameLabel.center = _coverImageView.center;
    _city_nameLabel.font = [UIFont systemFontOfSize:25.f];
    _city_nameLabel.textAlignment = NSTextAlignmentCenter;
    [_coverImageView addSubview:_city_nameLabel];
    
    
    
    for (int i = 0; i < 4; i++) {
        TabView *tabView = [[TabView alloc] initWithFrame:CGRectMake(i * (self.width / 4), _coverImageView.height, self.width / 4, self.height / 3)];
        tabView.tag = 1000 + i;
        [self addSubview:tabView];
    }

#pragma mark - 更多城市三个Label
    UILabel *moreCityLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - 100) / 2, _coverImageView.height + self.width / 4, 100, 20)];
    moreCityLabel.text = @"更多城市";
    moreCityLabel.font = [UIFont systemFontOfSize:14.f];
    moreCityLabel.textColor = [UIColor grayColor];
    moreCityLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:moreCityLabel];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (self.bounds.size.width - 100) / 2, 1)];
    leftLabel.backgroundColor = [UIColor colorWithWhite:0.749 alpha:1.000];
    leftLabel.center = CGPointMake(-((self.bounds.size.width - 100) / 2 / 2), moreCityLabel.height / 2);
    [moreCityLabel addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (self.bounds.size.width - 100) / 2, 1)];
    rightLabel.center = CGPointMake(((self.bounds.size.width - 100) / 2 / 2) + moreCityLabel.bounds.size.width, moreCityLabel.height / 2);
    rightLabel.backgroundColor = [UIColor colorWithWhite:0.749 alpha:1.000];
    [moreCityLabel addSubview:rightLabel];
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        button.layer.cornerRadius = 15.f;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000].CGColor;
        [button.layer setBorderWidth:1.0f];
        
        button.tag = 1500 + i;
        CGFloat width = (_coverImageView.bounds.size.width - 10 * 2 - 15 * 2) / 3;
        // 上面所有视图的高度和
        CGFloat upHeight = _coverImageView.height + self.width / 4;
        button.frame = CGRectMake(15 + i * (width + 10), upHeight + (self.height - upHeight - 30) / 2, width, 30);
        [self addSubview:button];
        
    }
    
    
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    NSNumber *num = [_dataDic objectForKey:@"city_id"];
    NSString *city_id = [NSString stringWithFormat:@"%@", num];
    [self.delegate AZ_DeliverCity_ID:city_id];
    
}


- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    NSURL *coverUrl = [NSURL URLWithString:[dataDic objectForKey:@"cover"]];
    [_coverImageView sd_setImageWithURL:coverUrl];
    
    _titleLabel.text = [dataDic objectForKey:@"title"];
    _city_nameLabel.text = [dataDic objectForKey:@"city_name"];
    
    NSArray *tabArray = [dataDic objectForKey:@"tab"];
    for (int i = 0; i < 4; i++) {
        NSDictionary *tabDic = tabArray[i];
        TabView *tabView = [self viewWithTag:1000 + i];
        tabView.tabDic = tabDic;
    }
    
    NSArray *recommend_cityArray = [dataDic objectForKey:@"recommend_city"];
    for (int i = 0; i < 3; i++) {
        NSDictionary *recommend_cityDic = recommend_cityArray[i];
        UIButton *button = [self viewWithTag:1500 + i];
        [button setTitle:[recommend_cityDic objectForKey:@"city_name"] forState:UIControlStateNormal];
    }
    
}







@end
