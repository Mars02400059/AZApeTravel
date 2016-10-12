//
//  HotGoodsArrayModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/10.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "HotGoodsArrayModel.h"

@implementation HotGoodsArrayModel

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([key isEqualToString:@"hot_goods"]) {
        NSArray *hot_goodsDicArray = value;
        NSMutableArray *hotGoodsArray = [NSMutableArray array];
        for (NSDictionary *hotGoodsDic in hot_goodsDicArray) {
            HotGoodsModel *hotGoodsModel = [[HotGoodsModel alloc] initWithDic:hotGoodsDic];
            [hotGoodsArray addObject:hotGoodsModel];
        }
        self.hot_goodsArray = hotGoodsArray;
        return;
    }
    [super setValue:value forKey:key];

}


@end
