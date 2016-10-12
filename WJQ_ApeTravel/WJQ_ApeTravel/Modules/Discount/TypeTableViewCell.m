//
//  TypeTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/11.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "TypeTableViewCell.h"
#import "TypeSubsCollectionViewCell.h"
#import "Hot_AreaSubViewTableViewCell.h"


static NSString *const tableViewCell = @"tableViewCell";
static NSString *const collectionViewCell = @"collectionViewCell";


@interface TypeTableViewCell ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *backLabel;

@property (nonatomic, strong) NSMutableArray *tableViewArray;

@property (nonatomic, strong) NSMutableArray *collectionViewArray;


@end

@implementation TypeTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.tableViewArray = [NSMutableArray array];
        self.collectionViewArray = [NSMutableArray array];
        
        self.titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:20.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        self.flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor= [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TypeSubsCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
        [self.contentView addSubview:_collectionView];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[Hot_AreaSubViewTableViewCell class] forCellReuseIdentifier:tableViewCell];
        [self.contentView addSubview:_tableView];
        
        self.backLabel = [UILabel new];
        _backLabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        [self.contentView addSubview:_backLabel];
        
    }
    
    return self;

}


- (void)setTypeModel:(DiscountTypeDataModel *)typeModel {
    _typeModel = typeModel;
    _titleLabel.text = typeModel.area;
    [_tableViewArray removeAllObjects];
    [_collectionViewArray removeAllObjects];
    
    [_tableViewArray addObjectsFromArray:typeModel.list];
    [_collectionViewArray addObjectsFromArray:typeModel.poi];
    
    [_tableView reloadData];
    [_collectionView reloadData];

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _collectionViewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TypeSubsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    cell.poiModel = _collectionViewArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscountTypeDataListModel *listModel = _tableViewArray[indexPath.row];
    [self.delegate AZ_typeListIdNumber:listModel.idNumber];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Hot_AreaSubViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    cell.typeListModel = _tableViewArray[indexPath.row];
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    // 高度 60 + itemHeight * 3 + 10 * 2 + 20 + (self.contentView.width - 15 * 2) * 1.2 + 10
    _titleLabel.frame = CGRectMake(0, 0, self.width, 60);
    
    CGFloat itemWidth = (self.contentView.width - 10 * 2 - 15 * 2) / 3;
    CGFloat itemHeight = itemWidth / 3;
    _flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    _flowLayout.minimumLineSpacing = 10.f;
    _flowLayout.minimumInteritemSpacing = 10.f;
    
    
    _collectionView.frame = CGRectMake(15, _titleLabel.height, self.contentView.width - 15 * 2, itemHeight * 3 + 10 * 2 + 20);
    
    _tableView.frame = CGRectMake(15, _collectionView.y + _collectionView.height, _collectionView.width, _collectionView.width * 0.9);
    _tableView.rowHeight = _collectionView.width * 0.3;
    
    _backLabel.frame = CGRectMake(0, self.contentView.height - 10, self.contentView.width, 10);

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
