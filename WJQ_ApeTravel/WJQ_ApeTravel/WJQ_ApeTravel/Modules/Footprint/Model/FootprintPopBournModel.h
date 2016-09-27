//
//  FootprintPopBournModel.h
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface FootprintPopBournModel : AZBaseModel

/// 国家
@property (nonatomic, copy) NSString *cnname;
/// 国家英文
@property (nonatomic, copy) NSString *enname;
/// 排名
@property (nonatomic, assign) NSInteger count;
/// 城市或旅行地
@property (nonatomic, copy) NSString *label;
/// 图片
@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *idnumber;

@end
