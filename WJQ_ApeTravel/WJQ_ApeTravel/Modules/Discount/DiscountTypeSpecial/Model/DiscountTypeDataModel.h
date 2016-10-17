//
//  DiscountTypeDataModel.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/11.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface DiscountTypeDataModel : AZBaseModel

@property (nonatomic, copy) NSString *area;

@property (nonatomic, strong) NSArray *poi;

@property (nonatomic, strong) NSArray *list;


@end
