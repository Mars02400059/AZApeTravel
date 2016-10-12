//
//  Most_PopularModel.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface Most_PopularModel : AZBaseModel

@property (nonatomic, copy) NSString *idNumber;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) CGFloat score;

@end
