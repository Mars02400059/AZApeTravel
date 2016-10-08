//
//  OldCityViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "OldCityViewController.h"
#import "OldCityCollectionViewCell.h"

static NSInteger number = 2;

static NSString *const Cell = @"cell";

@interface OldCityViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionViewArray;

@end

@implementation OldCityViewController

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.collectionViewArray = [NSMutableArray array];
    self.navigationItem.title = @"全部城市";
    UICollectionViewFlowLayout *flowYout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (self.view.width - 25 * 2 - 20) / 2;
    CGFloat itemHeight = itemWidth * 1.2;
    flowYout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowYout.minimumLineSpacing = 20.f;
    flowYout.minimumInteritemSpacing = 20.f;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(25, 64, self.view.width - 25 * 2, self.view.height - 64) collectionViewLayout:flowYout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[OldCityCollectionViewCell class] forCellWithReuseIdentifier:Cell];
    [self.view addSubview:_collectionView];
    
    //默认【上拉加载】
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self asyncLoadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TravelSiteViewController *travelVC = [[TravelSiteViewController alloc] init];
    OldCityModel *oldCityModel = _collectionViewArray[indexPath.row];
    travelVC.city_id = oldCityModel.idNumber;
    [self.navigationController pushViewController:travelVC animated:YES];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectionViewArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OldCityCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:Cell forIndexPath:indexPath];
    cell.oldCityModel = _collectionViewArray[indexPath.row];
    return cell;

}

// 网络请求
- (void)asyncLoadData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/place/city/get_city_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=%@&countryid=%@&lat=41.19759848641075&lon=125.6096293717715&page=1&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&v=1", _oblastID, _countryID];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *dataDic in dataArray) {
                OldCityModel *oldCityModel = [[OldCityModel alloc] initWithDic:dataDic];
                [_collectionViewArray addObject:oldCityModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_collectionView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
        
    });
}
- (void)loadMore {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/place/city/get_city_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=%@&countryid=%@&lat=41.19759848641075&lon=125.6096293717715&page=%ld&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&v=1", _oblastID, _countryID, number];
        number++;
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *dataDic in dataArray) {
                OldCityModel *oldCityModel = [[OldCityModel alloc] initWithDic:dataDic];
                [_collectionViewArray addObject:oldCityModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_collectionView.mj_footer endRefreshing];
                [_collectionView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
        
    });


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
