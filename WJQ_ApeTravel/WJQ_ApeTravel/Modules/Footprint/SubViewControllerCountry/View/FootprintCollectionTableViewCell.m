//
//  FootprintCollectionTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/27.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "FootprintCollectionTableViewCell.h"
#import "FootPrintTwoCollectionViewCell.h"
#import "CityModel.h"

static NSString *const collectionCell = @"cell";

@interface FootprintCollectionTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
/**
 *  占位
 */
@property (nonatomic, strong) UILabel *grayLabel;
/**
 *  <#Description#>
 */
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation FootprintCollectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.grayLabel = [UILabel new];
        _grayLabel.backgroundColor = [UIColor colorWithWhite:0.856 alpha:1.000];
        [self.contentView addSubview:_grayLabel];

        
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 10.f;
        _flowLayout.minimumInteritemSpacing = 10.f;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[FootPrintTwoCollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
        [self.contentView addSubview:_collectionView];
        
        
        
    }
    return self;
}

- (void)setHot_cityArray:(NSArray *)hot_cityArray {
    _hot_cityArray = hot_cityArray;
    [_collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    CityModel *cityModel = _hot_cityArray[indexPath.row];

    [self.delegate AZ_SelectedIDNumber:cityModel.idNumber];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _hot_cityArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FootPrintTwoCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    CityModel *cityModel = _hot_cityArray[indexPath.row];
    cell.cityModel = cityModel;
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _grayLabel.frame = CGRectMake(15, 1, self.contentView.width - 15 * 2, 1);
    CGFloat itemWinth = (self.contentView.width - 15 * 2 - 10) / 2;
    _flowLayout.itemSize = CGSizeMake(itemWinth, itemWinth * 0.6);
    
    _collectionView.frame = CGRectMake(15, 10, self.contentView.width - 15 * 2, self.contentView.height - 10);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
