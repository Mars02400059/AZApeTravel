//
//  DiscountCityListModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/12.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "DiscountCityListModel.h"

@implementation DiscountCityListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        self.idNumber = value;
        return;
    }
    [super setValue:value forUndefinedKey:key];

}

@end
