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
    

    [super setValue:value forKey:key];
}



@end
