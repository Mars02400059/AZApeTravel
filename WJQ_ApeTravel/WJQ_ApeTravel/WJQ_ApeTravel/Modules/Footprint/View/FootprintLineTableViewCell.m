//
//  FootprintLineTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/27.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "FootprintLineTableViewCell.h"

@interface FootprintLineTableViewCell ()

// 线
@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation FootprintLineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lineLabel = [UILabel new];
        _lineLabel.backgroundColor = [UIColor colorWithRed:0.552 green:0.543 blue:0.553 alpha:1.000];
        [self.contentView addSubview:_lineLabel];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _lineLabel.frame = CGRectMake(15, self.contentView.height - 1, self.contentView.width - 15 * 2, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
