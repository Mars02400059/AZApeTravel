//
//  EnterViewTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/6.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "EnterViewTableViewCell.h"

@interface EnterViewTableViewCell ()


@property (nonatomic, strong) UILabel *backLabel;

@end

@implementation EnterViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
        self.titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:20.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        self.backLabel = [UILabel new];
        _backLabel.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
        [self.contentView addSubview:_backLabel];
        
    }
    return self;
}

- (void)setEnterForumListModel:(EnterForumListModel *)enterForumListModel {
    _enterForumListModel = enterForumListModel;
    _titleLabel.text = enterForumListModel.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = self.bounds;
    
    _backLabel.frame = CGRectMake(0, self.contentView.height - 0.5, self.contentView.width, 0.5);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
