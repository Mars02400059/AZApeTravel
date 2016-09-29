//
//  NOMissTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/28.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "NOMissTableViewCell.h"
#import "NOMissSubsTableViewCell.h"

@interface NOMissTableViewCell ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UILabel *backLabel;

@property (nonatomic, strong) UILabel *myLabel;

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation NOMissTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backLabel = [UILabel new];
        _backLabel.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.000];
        [self.contentView addSubview:_backLabel];
        
        self.myLabel = [UILabel new];
        _myLabel.text = @"不可错过";
        _myLabel.backgroundColor = [UIColor whiteColor];
        _myLabel.textColor = [UIColor blackColor];
        _myLabel.font = [UIFont systemFontOfSize:22.f];
        _myLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_myLabel];
        
        self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
#warning 关闭tableView滑动
        _myTableView.scrollEnabled= NO;

        _myTableView.backgroundColor = [UIColor cyanColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [self.contentView addSubview:_myTableView];
        
    }
    return self;
}

- (void)setNot_missArray:(NSArray *)not_missArray {
    _not_missArray = not_missArray;
    [_myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _not_missArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const noMissCell = @"cell";
    
    NOMissSubsTableViewCell *cell = [_myTableView dequeueReusableCellWithIdentifier:noMissCell];
    
    if (cell == nil) {
        cell = [[NOMissSubsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:noMissCell];
    }
    
    Not_MissModel *notmissModel = _not_missArray[indexPath.row];
    cell.not_missModel = notmissModel;
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 总高度 (self.contentView.width * 0.5 + 70) * _not_missArray.count + 10 + 60
    _backLabel.frame = CGRectMake(0, 0, self.contentView.width, 10);
    
    _myLabel.frame = CGRectMake(0, 10, self.contentView.width, 60);
    
    _myTableView.frame = CGRectMake(0, _myLabel.height + 10, self.contentView.width, (self.contentView.width * 0.5 + 70) * 3);
    
    _myTableView.rowHeight = self.contentView.width * 0.5 + 70;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
