//
//  HotGoodTableViewCell.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HotGoodTableViewCellDelegate <NSObject>

- (void)AZ_hotGoodTableViewCellIdNumber:(NSString *)idNumber;

@end

@interface HotGoodTableViewCell : UITableViewCell

@property (nonatomic, strong) HotGoodsArrayModel *hot_goodsArrayModel;

@property (nonatomic, assign) id<HotGoodTableViewCellDelegate>delegate;

@end
