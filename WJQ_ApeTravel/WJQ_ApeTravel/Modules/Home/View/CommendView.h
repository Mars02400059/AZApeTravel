//
//  CommendView.h
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseView.h"

@protocol CommendViewDelegate <NSObject>

- (void)AZ_DeliverCity_ID:(NSString *)city_id;

@end

@interface CommendView : AZBaseView


@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, assign) id<CommendViewDelegate>delegate;

@end
