//
//  ContinentModel.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "ContinentModel.h"

@implementation ContinentModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _oblastID = (NSString *)value;
        return;
    }
    [super setValue:value forUndefinedKey:key];
}



@end
