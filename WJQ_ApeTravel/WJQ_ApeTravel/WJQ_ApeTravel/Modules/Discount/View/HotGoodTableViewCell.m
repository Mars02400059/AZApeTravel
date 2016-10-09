//
//  HotGoodTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/29.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "HotGoodTableViewCell.h"
#import "HotGoodCollectionViewCell.h"
static NSString *const collectionViewCell = @"cell";

@interface HotGoodTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) UILabel *backlabel;

@property (nonatomic, strong) UILabel *myLabel;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLaout;

@property (nonatomic, strong) UICollectionView *hot_goodsCollectionView;
@property (nonatomic, strong) NSMutableArray *hotgoodsArray;

@end

@implementation HotGoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.hotgoodsArray = [NSMutableArray array];
        self.backlabel = [UILabel new];
        _backlabel.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000];
        [self.contentView addSubview:_backlabel];
        
        self.myLabel = [UILabel new];
        _myLabel.font = [UIFont systemFontOfSize:20.f];
        _myLabel.textAlignment = NSTextAlignmentCenter;
        _myLabel.text = @"有好货";
        [self.contentView addSubview:_myLabel];
        
        self.flowLaout = [UICollectionViewFlowLayout new];
        
        self.hot_goodsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLaout];
        _hot_goodsCollectionView.backgroundColor = [UIColor whiteColor];
        _hot_goodsCollectionView.delegate = self;
        _hot_goodsCollectionView.dataSource = self;
        [self.contentView addSubview:_hot_goodsCollectionView];
        [_hot_goodsCollectionView registerClass:[HotGoodCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
    }
    
    return self;
}
- (void)setHot_goodsArray:(NSMutableArray *)hot_goodsArray {
    
    _hot_goodsArray = hot_goodsArray;
    [_hotgoodsArray removeAllObjects];
    _hotgoodsArray = hot_goodsArray;
    [_hot_goodsCollectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HotGoodsModel *hotGoodsModel = _hotgoodsArray[indexPath.row];
    [self.delegate AZ_hotGoodTableViewCellIdNumber:hotGoodsModel.idNumber];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _hotgoodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotGoodCollectionViewCell *cell = [_hot_goodsCollectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    HotGoodsModel *hotGoodsModel = _hotgoodsArray[indexPath.row];
    cell.hotGoodsModel = hotGoodsModel;
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Cell 高度 10 + 60 + itemWidth * 1.2 * 3 + 20 * 2
    
    _backlabel.frame = CGRectMake(0, 0, self.contentView.width, 10);
    _myLabel.frame = CGRectMake(0, 10, self.contentView.width, 60);
    
    CGFloat itemWidth = (self.contentView.width - 20 * 3) / 2;
    
    _flowLaout.itemSize = CGSizeMake(itemWidth, itemWidth * 1.2);
    _flowLaout.minimumLineSpacing = 20.f;
    _flowLaout.minimumInteritemSpacing = 20.f;
    
    _hot_goodsCollectionView.frame = CGRectMake(20, _backlabel.height + _myLabel.height, self.contentView.width - 20 * 2, itemWidth * 1.2 * 3 + 20 * 2);


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
