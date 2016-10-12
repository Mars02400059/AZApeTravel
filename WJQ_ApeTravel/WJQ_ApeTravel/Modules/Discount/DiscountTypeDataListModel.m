
//
//  DiscountTypeDataListModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/11.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "DiscountTypeDataListModel.h"

@implementation DiscountTypeDataListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.idNumber = value;
        return;
    }
    [super setValue:value forUndefinedKey:key];

}


@end
