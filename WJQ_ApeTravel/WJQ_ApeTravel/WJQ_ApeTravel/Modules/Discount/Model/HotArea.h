//
//  HotArea.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface HotArea : AZBaseModel

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSArray *place;

@property (nonatomic, strong) NSArray *list;

@end
