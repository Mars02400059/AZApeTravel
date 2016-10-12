//
//  DiscountTopic.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "DiscountTopic.h"

@implementation DiscountTopic

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"list"]) {
        NSArray *discountTopicListArray = value;
        NSMutableArray *discountTopicListModelArray = [NSMutableArray array];
        for (NSDictionary *discountTopicListDic in discountTopicListArray) {
            DiscountTopicListModel *discountTopicListModel = [[DiscountTopicListModel alloc] initWithDic:discountTopicListDic];
            [discountTopicListModelArray addObject:discountTopicListModel];
        }
        self.listArray = discountTopicListModelArray;
        return;
    }
    [super setValue:value forUndefinedKey:key];

}


@end
