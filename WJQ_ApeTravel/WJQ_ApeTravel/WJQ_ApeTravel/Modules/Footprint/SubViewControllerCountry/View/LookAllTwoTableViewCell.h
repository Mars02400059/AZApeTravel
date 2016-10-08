//
//  LookAllTwoTableViewCell.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/6.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LookAllTwoTableViewCellDataSource <NSObject>

- (void)AZ_transmitInfoAndSpringInspanPageTable;

@end

@interface LookAllTwoTableViewCell : UITableViewCell
@property (nonatomic, copy) NSString *labelText;

@property (nonatomic, assign) id<LookAllTwoTableViewCellDataSource>dataSource;

@end
