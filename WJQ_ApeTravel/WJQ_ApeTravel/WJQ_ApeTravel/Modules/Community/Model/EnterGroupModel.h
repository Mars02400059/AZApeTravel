//
//  EnterGroupModel.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/6.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface EnterGroupModel : AZBaseModel

@property (nonatomic, strong) NSNumber *idNumber;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *total_threads;

@property (nonatomic, copy) NSString *descriptionStr;

@end
