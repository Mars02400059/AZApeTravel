//
//  ContinentModel.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "ContinentModel.h"

@implementation ContinentModel

- (void)setCnname:(NSString *)cnname {
    NSString *str = [NSString stringWithFormat:@"%@热门目的地", cnname];
    _cnname = str;
}

@end
