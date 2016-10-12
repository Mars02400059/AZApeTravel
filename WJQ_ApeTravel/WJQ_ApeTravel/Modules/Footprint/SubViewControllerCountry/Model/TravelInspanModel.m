//
//  TravelInspanModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/26.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "TravelInspanModel.h"

@implementation TravelInspanModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.idNumber = value;
        return;
    }
    [super setValue:value forUndefinedKey:key];

}

@end
