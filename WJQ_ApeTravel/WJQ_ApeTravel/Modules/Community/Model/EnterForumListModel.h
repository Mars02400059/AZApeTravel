//
//  EnterForumListModel.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/6.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface EnterForumListModel : AZBaseModel

@property (nonatomic, strong) NSNumber *idNumber;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray *groupArray;

@end
