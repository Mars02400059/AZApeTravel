//
//  RegisterTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/30.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "RegisterTableViewCell.h"
#import "RegisterSubsTableViewCell.h"


@interface RegisterTableViewCell ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UILabel *myLabel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RegisterTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myLabel = [UILabel new];
        _myLabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        [self.contentView addSubview:_myLabel];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.contentView addSubview:_tableView];
        
        
        
        
    }
    return self;
}

- (void)setTableViewArray:(NSArray *)tableViewArray {
    _tableViewArray = tableViewArray;
    
    [_tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegisterSubsTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[RegisterSubsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.myLabelText = _tableViewArray[indexPath.row];
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _myLabel.frame = CGRectMake(0, 0, self.contentView.width, 10);
    
    
    _tableView.rowHeight = 60.f;
    _tableView.frame = CGRectMake(0, 10, self.contentView.width, _tableView.rowHeight * _tableViewArray.count);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
