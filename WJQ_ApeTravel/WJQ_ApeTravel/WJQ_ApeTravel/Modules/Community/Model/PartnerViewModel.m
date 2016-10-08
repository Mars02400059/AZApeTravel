//
//  PartnerViewModel.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "PartnerViewModel.h"

@implementation PartnerViewModel

- (void)setStart_time:(NSString *)start_time {
    NSString *starTime = start_time;
    int starDate = (int)[starTime integerValue];
    NSDate *starDate2 = [NSDate dateWithTimeIntervalSince1970:starDate];
    NSDateFormatter *starDate3 = [[NSDateFormatter alloc] init];
    [starDate3 setDateFormat:@"yyyy-MM-dd"];
    NSString *str1 = [starDate3 stringFromDate:starDate2];
    _start_time = str1;

}

- (void)setEnd_time:(NSString *)end_time {
    NSString *starTime = end_time;
    int starDate = (int)[starTime integerValue];
    NSDate *starDate2 = [NSDate dateWithTimeIntervalSince1970:starDate];
    NSDateFormatter *starDate3 = [[NSDateFormatter alloc] init];
    [starDate3 setDateFormat:@"yyyy-MM-dd"];
    NSString *str1 = [starDate3 stringFromDate:starDate2];
    _end_time = str1;

}

- (void)setPublish_time:(NSString *)publish_time {
    NSString *starTime = publish_time;
    int starDate = (int)[starTime integerValue];
    NSDate *starDate2 = [NSDate dateWithTimeIntervalSince1970:starDate];
    NSDateFormatter *starDate3 = [[NSDateFormatter alloc] init];
    [starDate3 setDateFormat:@"yyyy-MM-dd"];
    NSString *str1 = [starDate3 stringFromDate:starDate2];
    _publish_time = str1;

}

- (void)setUid:(NSString *)uid {
    

}

@end
