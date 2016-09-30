//
//  TravelInspanModel.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/26.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface TravelInspanModel : AZBaseModel

/**
 *  图片
 */
@property (nonatomic, copy) NSString *photo;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  打折
 */
@property (nonatomic, copy) NSString *priceoff;
/**
 *  价格
 */
@property (nonatomic, copy) NSString *price;

@end
