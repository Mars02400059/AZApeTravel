//
//  EnterForumListModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/6.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "EnterForumListModel.h"

@implementation EnterForumListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _idNumber = value;
        return;
    }
    
    if ([key isEqualToString:@"group"]) {

        NSArray *groupDicArray = value;
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *groupDic in groupDicArray) {
            EnterGroupModel *enterGroupModel = [[EnterGroupModel alloc] initWithDic:groupDic];
            [groupArray addObject:enterGroupModel];
        }
        self.groupArray = groupArray;
        return;

    }
    
    [super setValue:value forUndefinedKey:key];
}

@end
