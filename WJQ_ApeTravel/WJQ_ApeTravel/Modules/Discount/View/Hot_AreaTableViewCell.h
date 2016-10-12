//
//  Hot_AreaTableViewCell.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Hot_AreaTableViewCellDelegate <NSObject>

- (void)AZ_areaaTableViewDidIdNumber:(NSString *)idNumber;

- (void)AZ_areaButtonActionType:(NSString *)type typeName:(NSString *)typeName;

@end

@interface Hot_AreaTableViewCell : UITableViewCell

//@property (nonatomic, strong) NSArray *hotAreaPlaceArray;
//@property (nonatomic, strong) NSArray *hotAreaListArray;
//@property (nonatomic, strong) NSDictionary *hot_areaDic;
@property (nonatomic, strong) HotArea *hotArea;
@property (nonatomic, assign) id<Hot_AreaTableViewCellDelegate>delegate;

@end
