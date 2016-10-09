//
//  Hot_AreaTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "Hot_AreaTableViewCell.h"
#import "Hot_AreaSubViewTableViewCell.h"
#import "Hot_AreaSubViewCollectionViewCell.h"


static NSString *const collectionCell = @"collectionCell";
static NSString *const tableViewCell = @"tableViewCell";

@interface Hot_AreaTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UILabel *backlabel;

@property (nonatomic, strong) UILabel *myLabel;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *placeCollectionView;

@property (nonatomic, strong) UITableView *listTableView;

@property (nonatomic, strong) UIButton *myButton;

@property (nonatomic, strong) NSMutableArray *hotAreaPlaceArray;
@property (nonatomic, strong) NSMutableArray *hotAreaListArray;

@end

@implementation Hot_AreaTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.hotAreaPlaceArray = [NSMutableArray array];
        self.hotAreaListArray = [NSMutableArray array];
        
        self.backlabel = [UILabel new];
        _backlabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000];
        [self.contentView addSubview:_backlabel];
        
        self.myLabel = [UILabel new];
        _myLabel.font = [UIFont systemFontOfSize:20.f];
        _myLabel.textAlignment = NSTextAlignmentCenter;
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        self.placeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _placeCollectionView.backgroundColor = [UIColor whiteColor];
        _placeCollectionView.delegate = self;
        _placeCollectionView.dataSource = self;
        [_placeCollectionView registerClass:[Hot_AreaSubViewCollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
        [self.contentView addSubview:_placeCollectionView];
        
        self.listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTableView.scrollEnabled = NO;
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        [self.contentView addSubview:_listTableView];
        
        self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_myButton setTitleColor:[UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000] forState:UIControlStateNormal];
        [_myButton setTitle:@"查看专区>" forState:UIControlStateNormal];
        _myButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [self.contentView addSubview:_myButton];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // cell高 10 + 60 + (self.contentView.width - 20 * 2 - 15 * 3) + 60
    _backlabel.frame = CGRectMake(0, 0, self.contentView.width, 10);
    
    _myLabel.frame = CGRectMake(0, 10, self.contentView.width, 60);
    
    CGFloat itemWidth = (self.contentView.width - 20 * 2 - 15 * 3) / 4;
    _flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    _flowLayout.minimumLineSpacing = 15.f;
    _flowLayout.minimumInteritemSpacing = 15.f;
    
    _placeCollectionView.frame = CGRectMake(20, _backlabel.height + _myLabel.height, self.contentView.width - 20 * 2, itemWidth);
#warning 高度要改
    
#if 1
    _listTableView.frame = CGRectMake(20, _backlabel.height + _myLabel.height + _placeCollectionView.height, self.contentView.width - 20 * 2, itemWidth * 3);
    _listTableView.rowHeight = itemWidth * 1.5;
    
    _myButton.frame = CGRectMake(0, _backlabel.height + _myLabel.height + _placeCollectionView.height + _listTableView.height, self.contentView.width, 60);
    
#endif
}


- (void)setHotArea:(HotArea *)hotArea {
    _hotArea = hotArea;
    
    
    [_hotAreaListArray removeAllObjects];
    [_hotAreaPlaceArray removeAllObjects];
    for (HotAreaPlaceModel *hotAreaPlaceModel in hotArea.place) {
        [_hotAreaPlaceArray addObject:hotAreaPlaceModel];
    }
    

    for (HotAreaListModel *hotAreaListModel in hotArea.list) {
        
        [_hotAreaListArray addObject:hotAreaListModel];
    }
    
    [_listTableView reloadData];
    [_placeCollectionView reloadData];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _hotAreaPlaceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Hot_AreaSubViewCollectionViewCell *cell = [_placeCollectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    cell.placeModel = _hotAreaPlaceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HotAreaListModel *listModel = _hotAreaListArray[indexPath.row];
    NSString *idNumber = [NSString stringWithFormat:@"%@", listModel.idNumber];
    [self.delegate AZ_areaaTableViewDidIdNumber:idNumber];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _hotAreaListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Hot_AreaSubViewTableViewCell *cell = [_listTableView dequeueReusableCellWithIdentifier:tableViewCell];
    if (cell == nil) {
        cell = [[Hot_AreaSubViewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewCell];
    }
    cell.listModel = _hotAreaListArray[indexPath.row];
    return cell;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
