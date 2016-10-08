//
//  LookAllTableViewCell.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/27.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LookAllTableViewCellDelegate <NSObject>

- (void)AZ_transmitInfoAndSpringCityPageTable;

@end

@interface LookAllTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, assign) id<LookAllTableViewCellDelegate>delegate;

@end
