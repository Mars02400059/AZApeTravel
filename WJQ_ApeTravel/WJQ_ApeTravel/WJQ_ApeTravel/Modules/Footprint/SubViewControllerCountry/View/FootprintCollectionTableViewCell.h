//
//  FootprintCollectionTableViewCell.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/27.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FootprintCollectionTableViewCellDelegate <NSObject>

- (void)AZ_SelectedIDNumber:(NSString *)idNumber;

@end

@interface FootprintCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *hot_cityArray;

@property (nonatomic, assign) id<FootprintCollectionTableViewCellDelegate>delegate;

@end
