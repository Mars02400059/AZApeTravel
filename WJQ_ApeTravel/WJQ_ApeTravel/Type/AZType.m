//
//  AZType.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/11.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZType.h"

@implementation AZType


+ (void)AZTypeCacensWritePatchCachePatch:(NSString *)cachePatch cacheDic:(NSDictionary *)cacheDic {

    // 获取缓存路径
    NSArray *pathCachesArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [pathCachesArray firstObject];

    // 这种方式的拼接会自动在前面加一个"/"
    NSString *writePath = [cachesPath stringByAppendingPathComponent:cachePatch];
//    NSLog(@"nameArrayPath : %@", writePath);
    
    
    [cacheDic writeToFile:writePath atomically:YES];

}

- (NSDictionary *)AZTypeGetTakeCachePatch:(NSString *)cachePatch {
    
    
    // 获取缓存路径
    NSArray *pathCachesArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [pathCachesArray firstObject];
    
    // 这种方式的拼接会自动在前面加一个"/"
    NSString *writePath = [cachesPath stringByAppendingPathComponent:cachePatch];
    
    NSDictionary *getDic = [NSDictionary dictionaryWithContentsOfFile:writePath];

    return getDic;
}



@end
