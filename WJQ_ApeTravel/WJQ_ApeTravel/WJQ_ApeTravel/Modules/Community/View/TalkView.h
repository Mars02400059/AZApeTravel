//
//  TalkView.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseView.h"

@protocol TalkViewDelegate <NSObject>

- (void)AZ_talkViewTableViewSpringWebViewUrl:(NSString *)webViewUrl;

@end

@interface TalkView : AZBaseView

@property (nonatomic, assign) id<TalkViewDelegate>delegate;

@end
