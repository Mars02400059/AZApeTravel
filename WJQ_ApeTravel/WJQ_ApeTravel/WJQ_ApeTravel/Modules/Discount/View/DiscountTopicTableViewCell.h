//
//  DiscountTopicTableViewCell.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DiscountTopicTableViewCellDelegate <NSObject>

- (void)AZ_discountTopicIdNumber:(NSString *)idNumber;

@end

@interface DiscountTopicTableViewCell : UITableViewCell

@property (nonatomic, strong) DiscountTopic *discountTopicModel;

@property (nonatomic, assign) id<DiscountTopicTableViewCellDelegate>delegate;

@end
