//
//  EnterView.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/6.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "EnterView.h"
#import "EnterViewTableViewCell.h"
#import "EnterViewCollectionViewCell.h"


static NSString *const tableViewCell = @"tableViewCell";
static NSString *const collectionViewCell = @"collectionViewCell";

@interface EnterView ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate
>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger selecteRow;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowYout;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *forum_listArray;

@property (nonatomic, strong) NSMutableArray *groupArray;


@end

@implementation EnterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.groupArray = [NSMutableArray array];
        self.forum_listArray = [NSMutableArray array];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[EnterViewTableViewCell class] forCellReuseIdentifier:tableViewCell];
        [self addSubview:_tableView];
        
        self.flowYout = [UICollectionViewFlowLayout new];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowYout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[EnterViewCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
        [self addSubview:_collectionView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _tableView.frame = CGRectMake(0, 0, self.width / 7 * 2, self.height);
    CGFloat itemWidth = self.width - self.width / 7 * 2;
    _flowYout.itemSize = CGSizeMake(itemWidth, itemWidth / 7 * 2);
    _flowYout.minimumLineSpacing = 0.f;
    _flowYout.minimumInteritemSpacing = 0.f;
    _collectionView.frame = CGRectMake(_tableView.width, 0, itemWidth, self.height);
    self.selecteRow = 0;
    [self asyncLoadData:@"http://open.qyer.com/qyer/bbs/entry?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=867168024167485&track_app_version=6.9.4&track_app_channel=oppo&track_device_info=R7c&track_os=Android4.4.4&app_installtime=1468288096877&lat=38.883476&lon=121.54447"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat Height = self.width / 3 * 0.5;
    return Height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _forum_listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
    EnterViewTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:tableViewCell];
        cell.titleLabel.font = [UIFont systemFontOfSize:22.f];
        cell.titleLabel.textColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    
    EnterForumListModel *enterForumListModel = _forum_listArray[indexPath.row];
    cell.enterForumListModel = enterForumListModel;
    
    return cell;
    }
    
    EnterViewTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:tableViewCell];
    EnterForumListModel *enterForumListModel = _forum_listArray[indexPath.row];
    cell.enterForumListModel = enterForumListModel;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _collectionView.contentOffset = CGPointMake(0, 0);
    [_groupArray removeAllObjects];
    EnterForumListModel *enterForumListModel = _forum_listArray[indexPath.row];
    [_groupArray addObjectsFromArray:enterForumListModel.groupArray];
    [_collectionView reloadData];
    if (indexPath.row != 0) {
        
    }
#if 1
    if (tableView == _tableView) {
        //将前一个row还原
        
        EnterViewTableViewCell *cell1 = (EnterViewTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selecteRow inSection:0]];
        cell1.titleLabel.font = [UIFont systemFontOfSize:20.f];
        cell1.titleLabel.textColor = [UIColor blackColor];
        
        //获取当前点击的row:
        EnterViewTableViewCell *cell = (EnterViewTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.titleLabel.font = [UIFont systemFontOfSize:22.f];
        cell.titleLabel.textColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
        
        _selecteRow = indexPath.row;
        
        [_tableView reloadData];
    }
#endif
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _groupArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EnterViewCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    EnterGroupModel *enterGroupModel = _groupArray[indexPath.row];
    cell.enterGroupModel = enterGroupModel;
    return cell;
}
// 网络请求
- (void)asyncLoadData:(NSString *)urlString {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = urlString;
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_forum_listArray removeAllObjects];
            [_groupArray removeAllObjects];
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSArray *forum_listArray = [dataDic objectForKey:@"forum_list"];
            for (NSDictionary *forum_listDic in forum_listArray) {
                EnterForumListModel *enterForumListModel = [[EnterForumListModel alloc] initWithDic:forum_listDic];
                [_forum_listArray addObject:enterForumListModel];
            }
            NSDictionary *forum_listDic = forum_listArray[0];
            NSArray *groupArray = [forum_listDic objectForKey:@"group"];
            for (NSDictionary *groupDic in groupArray) {
                EnterGroupModel *enterGroupModel = [[EnterGroupModel alloc] initWithDic:groupDic];
                [_groupArray addObject:enterGroupModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_tableView reloadData];
                [_collectionView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
        
    });
}

@end
