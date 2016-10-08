//
//  OldCityModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "OldCityModel.h"

@implementation OldCityModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _idNumber = value;
        return;
    }
    [super setValue:value forUndefinedKey:key];
}

@end
