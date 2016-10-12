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
    
    _start_time = [self compareTime:start_time];

}

- (void)setEnd_time:(NSString *)end_time {
    _end_time = [self compareTime:end_time];
}


- (void)setPublish_time:(NSString *)publish_time {
    
    _publish_time = [self compareCurrentTime:publish_time];
}



- (NSString *)compareTime:(NSString *)str {
    NSString *starTime = str;
    int starDate = (int)[starTime integerValue];
    NSDate *starDate2 = [NSDate dateWithTimeIntervalSince1970:starDate];
    NSDateFormatter *starDate3 = [[NSDateFormatter alloc] init];
    [starDate3 setDateFormat:@"yyyy-MM-dd"];
    NSString *str1 = [starDate3 stringFromDate:starDate2];
    return str1;

}
- (NSString *)compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSString *starTime = str;
    int starDate = (int)[starTime integerValue];
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:starDate];

    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;

    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}


@end
