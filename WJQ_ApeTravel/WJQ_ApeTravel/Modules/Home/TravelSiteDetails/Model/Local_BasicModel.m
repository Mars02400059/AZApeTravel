//
//  Local_BasicModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "Local_BasicModel.h"

@implementation Local_BasicModel


- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.idNumber = value;
        return;
    }
    [super setValue:value forKey:key];

}

@end
