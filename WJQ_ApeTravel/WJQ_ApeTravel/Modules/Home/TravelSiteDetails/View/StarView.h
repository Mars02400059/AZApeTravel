//
//  StarView.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/3.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseView.h"

@interface StarView : AZBaseView

// 总共的长度
@property (nonatomic, assign) NSInteger maxStar;
//需要显示的星星的长度
@property (nonatomic, assign) NSInteger showStar;
// 根据字体大小来确定星星的大小
@property (nonatomic, assign) CGFloat starSize;
//未点亮时候的颜色
@property (nonatomic, retain) UIColor *emptyColor;
//点亮的星星的颜色
@property (nonatomic, retain) UIColor *fullColor;


@end
