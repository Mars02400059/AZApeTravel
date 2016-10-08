//
//  EnterGroupModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/6.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "EnterGroupModel.h"

@implementation EnterGroupModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _idNumber = value;
        return;
    }
    if ([key isEqualToString:@"description"]) {
        _descriptionStr = value;
        return;
    }
    
    [super setValue:value forUndefinedKey:key];
}

@end
