//
//  TalkViewModel.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface TalkViewModel : AZBaseModel
/// 头像
@property (nonatomic, copy) NSString *avatar;
/// 作者名
@property (nonatomic, copy) NSString *author;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 图片数组
@property (nonatomic, strong) NSArray *bigpic_arr;

@property (nonatomic, copy) NSString *forum;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *reply_time;

@property (nonatomic, strong) NSNumber *reply_num;
/// 点击webView链接
@property (nonatomic, copy) NSString *appview_url;

@end
