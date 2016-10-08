//
//  HotAreaPlaceModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "HotAreaPlaceModel.h"

@implementation HotAreaPlaceModel

- (void)setName:(NSString *)name {
    _name = name;

}

- (void)setPhoto:(NSString *)photo {
    _photo = photo;

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _idNumber = value;
        return;
    }
    
    [super setValue:value forUndefinedKey:key];
}

@end
