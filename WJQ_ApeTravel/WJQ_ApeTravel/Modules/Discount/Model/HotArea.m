//
//  HotArea.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "HotArea.h"

@implementation HotArea


- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"place"]) {
        NSArray *placeDicArray = value;
        NSMutableArray *placeModelArray = [NSMutableArray array];
        for (NSDictionary *placeDic in placeDicArray) {
            HotAreaPlaceModel *placeModel = [[HotAreaPlaceModel alloc] initWithDic:placeDic];
            [placeModelArray addObject:placeModel];
        }
        
        self.place = placeModelArray;
        return;
    }
    
    if ([key isEqualToString:@"list"]) {
        NSArray *listDicArray = value;
        NSMutableArray *listModelArray = [NSMutableArray array];
        for (NSDictionary *listDic in listDicArray) {
            HotAreaListModel *hotAreaListModel = [[HotAreaListModel alloc] initWithDic:listDic];
            [listModelArray addObject:hotAreaListModel];
        }
        self.list = listModelArray;
        return;
    }
    
    if ([key isEqualToString:@"type"]) {
        NSString *typeStr = value;
        self.type = value;
        if ([typeStr isEqualToString:@"gat"]) {
            self.typeName = @"港澳台";
            return;
        } else if ([typeStr isEqualToString:@"rh"]) {
            self.typeName = @"日韩";
            return;
        } else if ([typeStr isEqualToString:@"dny"]) {
            self.typeName = @"东南亚";
            return;
        } else if ([typeStr isEqualToString:@"om"]) {
            self.typeName = @"欧洲美国";
            return;
        }
        
    }

    [super setValue:value forKey:key];
}



@end
