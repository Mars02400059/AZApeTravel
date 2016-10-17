//
//  TypeTableViewCell.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/11.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeTableViewCellDelegate <NSObject>

- (void)AZ_typeListIdNumber:(NSString *)idNumber;

- (void)AZ_typeCollecionDidIdNumber:(NSString *)idNumber;

@end

@interface TypeTableViewCell : UITableViewCell

@property (nonatomic, strong) DiscountTypeDataModel *typeModel;

@property (nonatomic, assign) id<TypeTableViewCellDelegate>delegate;

@end
