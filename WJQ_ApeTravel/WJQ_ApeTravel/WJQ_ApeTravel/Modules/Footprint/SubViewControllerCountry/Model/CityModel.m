//
//  CityModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/26.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _idNumber = value;
        return;
    }
    [self setValue:value forUndefinedKey:key];
}

@end
