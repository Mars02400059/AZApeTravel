//
//  CountryModel.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/26.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface CountryModel : AZBaseModel
/**
 *  国家
 */
@property (nonatomic, copy) NSString *cnname;
/**
 *  国家英文
 */
@property (nonatomic, copy) NSString *enname;
/**
 *  简介
 */
@property (nonatomic, copy) NSString *entryCont;
/**
 *  轮播图图片
 */
@property (nonatomic, strong) NSArray *photos;



@end
