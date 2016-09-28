//
//  CityModel.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/26.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface CityModel : AZBaseModel

/**
 *  城市名
 */
@property (nonatomic, copy) NSString *cnname;
/**
 *  城市名(英文)
 */
@property (nonatomic, copy) NSString *enname;
/**
 *  图片
 */
@property (nonatomic, copy) NSString *photo;

@end
