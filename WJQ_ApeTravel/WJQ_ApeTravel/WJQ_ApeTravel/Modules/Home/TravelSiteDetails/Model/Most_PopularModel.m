//
//  Most_PopularModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "Most_PopularModel.h"

@implementation Most_PopularModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _idNumber = (NSString *)value;
        return;
    }
    [super setValue:value forUndefinedKey:key];
    
    
}

@end
