//
//  Not_MissModel.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseModel.h"

@interface Not_MissModel : AZBaseModel
/**
 *  标题
 */
@property (nonatomic, copy) NSString *name;
/**
 *  图片
 */
@property (nonatomic, copy) NSString *pic_url;
/**
 *  简介
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  webViewUrl
 */
@property (nonatomic, copy) NSString *link_url;

@end
