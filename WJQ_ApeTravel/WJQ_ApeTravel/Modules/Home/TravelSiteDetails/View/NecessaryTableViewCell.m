//
//  NecessaryTableViewCell.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/28.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "NecessaryTableViewCell.h"
#import "NecessaryCollectionViewCell.h"

static NSString *const collectionViewCell = @"cell";

@interface NecessaryTableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) UILabel *backLabel;

@property (nonatomic, strong) UILabel *myLabel;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *button;


@end

@implementation NecessaryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backLabel = [UILabel new];
        _backLabel.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.000];
        [self.contentView addSubview:_backLabel];
        
        self.myLabel = [UILabel new];
        _myLabel.text = @"当地游必备";
        _myLabel.backgroundColor = [UIColor whiteColor];
        _myLabel.textColor = [UIColor blackColor];
        _myLabel.font = [UIFont systemFontOfSize:22.f];
        _myLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_myLabel];
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.contentView addSubview:_collectionView];
        [_collectionView registerClass:[NecessaryCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
        
        
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitleColor:[UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000] forState:UIControlStateNormal];
        [_button setTitle:@"全部玩乐 >" forState:UIControlStateNormal];
        [self.contentView addSubview:_button];
        
    }
    return self;
}

- (void)setLocal_basicArray:(NSArray *)local_basicArray {
    _local_basicArray = local_basicArray;
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _local_basicArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NecessaryCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    Local_BasicModel *local_basicModel = _local_basicArray[indexPath.row];
    cell.local_basicModel = local_basicModel;
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 总高度 10 + 60 + (self.contentView.width - 20 * 3) / 2 * 1.5 * 2 + 20 + 60
    _backLabel.frame = CGRectMake(0, 0, self.contentView.width, 10);
    
    _myLabel.frame = CGRectMake(0, 10, self.contentView.width, 60);
    
    CGFloat itemWidth = (self.contentView.width - 20 * 3) / 2;
    
    _flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth * 1.5);
    
    _flowLayout.minimumLineSpacing = 20.f;
    _flowLayout.minimumInteritemSpacing = 20.f;
    
    _collectionView.frame = CGRectMake(20, 10 + _myLabel.height, self.contentView.width - 20 * 2, itemWidth * 1.5 * 2 + 20);
    
    _button.frame = CGRectMake(0, _collectionView.y + _collectionView.height, self.contentView.width, 60);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
