//
//  NecessaryTableViewCell.h
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/28.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NecessaryTableViewCellDelegate <NSObject>

- (void)AZ_necesaryCityIdNumber:(NSString *)idNumber;

@end

@interface NecessaryTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *local_basicArray;

@property (nonatomic, assign) id<NecessaryTableViewCellDelegate>delegate;

@end
