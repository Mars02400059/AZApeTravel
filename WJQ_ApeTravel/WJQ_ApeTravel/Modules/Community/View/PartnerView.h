//
//  PartnerView.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseView.h"

@protocol PartnerViewDelegate <NSObject>

- (void)AZ_partnerViewTableViewSpringVCWebViewUrl:(NSString *)webViewUrl;

@end

@interface PartnerView : AZBaseView

@property (nonatomic, assign) id<PartnerViewDelegate>delegate;

@end
