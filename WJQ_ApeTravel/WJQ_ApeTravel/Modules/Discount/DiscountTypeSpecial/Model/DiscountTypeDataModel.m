//
//  DiscountTypeDataModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/11.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "DiscountTypeDataModel.h"

@implementation DiscountTypeDataModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"poi"]) {
        NSArray *poiDicArray = value;
        NSMutableArray *poiArray = [NSMutableArray array];
        for (NSString *poiStr in poiDicArray) {
            DiscountTypeDataPoiModel *poiModel = [[DiscountTypeDataPoiModel alloc] init];
            poiModel.cityName = poiStr;
            [poiArray addObject:poiModel];
        }
        self.poi = poiArray;
        return;
    }
    if ([key isEqualToString:@"list"]) {
        NSArray *listDicArray = value;
        NSMutableArray *listArray = [NSMutableArray array];
        for (NSDictionary *listDic in listDicArray) {
            DiscountTypeDataListModel *listModel = [[DiscountTypeDataListModel alloc] initWithDic:listDic];
            [listArray addObject:listModel];
        }
        self.list = listArray;
        return;
    }
    
    [super setValue:value forKey:key];

}


@end
