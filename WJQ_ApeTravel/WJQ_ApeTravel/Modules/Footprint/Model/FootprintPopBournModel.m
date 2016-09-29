//
//  FootprintPopBournModel.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "FootprintPopBournModel.h"

@implementation FootprintPopBournModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _countryID = (NSString *)value;
        return;
    }
    [super setValue:value forUndefinedKey:key];
}

@end
