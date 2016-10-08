//
//  PartnerViewModel.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface PartnerViewModel : AZBaseModel

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *citys_str;

@property (nonatomic, strong) NSNumber *views;

@property (nonatomic, copy) NSString *replys;


@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *publish_time;

@property (nonatomic, copy) NSString *uid;

/// webView
@property (nonatomic, copy) NSString *appview_url;

@end
