//
//  DiscountTopicTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "DiscountTopicTableViewCell.h"
#import "Hot_AreaSubViewTableViewCell.h"
#import "DiscountTopic.h"

@interface DiscountTopicTableViewCell ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UILabel *backlabel;

@property (nonatomic, strong) UILabel *myLabel;

@property (nonatomic, strong) UITableView *listTableView;

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UIButton *myButton;

@property (nonatomic, strong) NSDictionary *topicDic;

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation DiscountTopicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.listArray = [NSMutableArray array];
        
        self.backlabel = [UILabel new];
        _backlabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000];
        [self.contentView addSubview:_backlabel];
        
        self.myLabel = [UILabel new];
        _myLabel.font = [UIFont systemFontOfSize:20.f];
        _myLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_myLabel];
        
        self.listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTableView.scrollEnabled = NO;
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        [self.contentView addSubview:_listTableView];
        
        self.headerImageView = [UIImageView new];
        _headerImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *headerImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageViewTapAction)];
        [_headerImageView addGestureRecognizer:headerImageViewTap];
        
        self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_myButton setTitleColor:[UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000] forState:UIControlStateNormal];
        [_myButton setTitle:@"查看完整专题 >" forState:UIControlStateNormal];
        [_myButton addTarget:self action:@selector(myButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _myButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [self.contentView addSubview:_myButton];
        
    }
    
    return self;
}

- (void)headerImageViewTapAction {
    [self.delegate AZ_discountImageViewTapIdNumber:[_topicDic objectForKey:@"link_url"]];
}

- (void)myButtonAction {
    [self.delegate AZ_discountImageViewTapIdNumber:[_topicDic objectForKey:@"link_url"]];
}

- (void)setDiscountTopicModel:(DiscountTopic *)discountTopicModel {
    _discountTopicModel = discountTopicModel;

    self.topicDic = discountTopicModel.topic;
    
    _myLabel.text = [_topicDic objectForKey:@"title"];
    NSURL *url = [NSURL URLWithString:[_topicDic objectForKey:@"photo"]];
    [_headerImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"啊"]];
    
    [_listArray addObjectsFromArray:discountTopicModel.listArray];
    
    [_listTableView reloadData];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscountTopicListModel *listModel = _listArray[indexPath.row];
    [self.delegate AZ_discountTopicIdNumber:listModel.idNumber];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Hot_AreaSubViewTableViewCell *cell = [_listTableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[Hot_AreaSubViewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    DiscountTopicListModel *listModel = _listArray[indexPath.row];
    cell.topicListModel = listModel;
    return cell;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // cell 高度 10 + 60 + Width * 0.4 + itemWidth * 1.5 * 3 + 60
    _backlabel.frame = CGRectMake(0, 0, self.contentView.width, 10);
    
    _myLabel.frame = CGRectMake(0, 10, self.contentView.width, 60);
    

    CGFloat Width = self.contentView.width - 20 * 2;
    
    CGFloat itemWidth = (self.contentView.width - 20 * 2 - 15 * 3) / 4;
    
    _listTableView.frame = CGRectMake(20, _backlabel.height + _myLabel.height, Width, Width * 0.4 + itemWidth * 1.5 * 3);

    _listTableView.rowHeight = itemWidth * 1.5;
    
    _headerImageView.height = Width * 0.4;
    _headerImageView.width = _listTableView.width;
    _listTableView.tableHeaderView = _headerImageView;

    _myButton.frame = CGRectMake(0, _backlabel.height + _myLabel.height + _listTableView.height, self.contentView.width, 60);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
