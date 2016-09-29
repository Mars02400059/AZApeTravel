//
//  TravelSiteViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/28.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "TravelSiteViewController.h"
#import "FoodprintHeadCollectionViewCell.h"
#import "NOMissTableViewCell.h"
#import "BestWelcomeTableViewCell.h"
#import "NecessaryTableViewCell.h"


static NSString *const collectionCell = @"collectionCell";

@interface TravelSiteViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) UITableView *travelSiteTableView;

/**
 *  轮播图
 */
@property (nonatomic, strong) UICollectionView *collectionView;

// 定时器
@property (nonatomic, strong) NSTimer *timer;
/**
 *  轮播图图片
 */
@property (nonatomic, strong) NSMutableArray *collectionViewArray;

@property (nonatomic, strong) UILabel *canameLabel;

@property (nonatomic, strong) UILabel *ennameLabel;

@property (nonatomic, strong) NSMutableDictionary *dataDic;
// 天气预报
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) NSMutableArray *not_missArray;

@property (nonatomic, strong) NSMutableArray *most_popularArray;
@property (nonatomic, strong) NSMutableArray *local_basicArray;

@end

@implementation TravelSiteViewController

- (void)viewWillAppear:(BOOL)animated {
    
    /**
     * 导航栏效果
     */
    self.navigationController.navigationBar.hidden = YES;
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    
    
}

- (void)viewDidLoad {
    self.local_basicArray = [NSMutableArray array];
    self.most_popularArray = [NSMutableArray array];
    self.not_missArray = [NSMutableArray array];
    self.dataDic = [NSMutableDictionary dictionary];
    self.collectionViewArray = [NSMutableArray array];
    [super viewDidLoad];
    [self createSlideView];
}

- (void)createSlideView {
    
    self.travelSiteTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _travelSiteTableView.showsVerticalScrollIndicator = NO;
    _travelSiteTableView.backgroundColor = [UIColor cyanColor];
    _travelSiteTableView.delegate = self;
    _travelSiteTableView.dataSource = self;
    [self.view addSubview:_travelSiteTableView];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _travelSiteTableView.width, _travelSiteTableView.width * 0.7)];
    
    headerView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.000];
    _travelSiteTableView.tableHeaderView = headerView;
    
#pragma mark - 轮播图
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(headerView.width,  headerView.width * 0.7);
    flowLayout.minimumLineSpacing = 0.f;
    flowLayout.minimumInteritemSpacing = 0.f;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.width * 0.7) collectionViewLayout:flowLayout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor redColor];
    [headerView addSubview:_collectionView];
    [_collectionView registerClass:[FoodprintHeadCollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
    if (_timer) {
        [_timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    // 国家名, 中文
    self.canameLabel = [[UILabel alloc] initWithFrame:CGRectMake((_collectionView.width - 140) / 2, _collectionView.height / 3, 140, 40)];
    _canameLabel.textColor = [UIColor whiteColor];
    _canameLabel.textAlignment = NSTextAlignmentCenter;
    _canameLabel.font = [UIFont systemFontOfSize:25.f];
    [headerView addSubview:_canameLabel];
    
    // 国家名, 英文
    self.ennameLabel = [[UILabel alloc] initWithFrame:CGRectMake((_collectionView.width - 200) / 2, _collectionView.height / 2, 200, 30)];
    _ennameLabel.center = CGPointMake(_collectionView.center.x, _collectionView.center.y);
    _ennameLabel.textAlignment = NSTextAlignmentCenter;
    _ennameLabel.font = [UIFont systemFontOfSize:18.f];
    _ennameLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:_ennameLabel];
    self.weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _collectionView.height / 6 * 5, 200, 30)];
    _weatherLabel.textColor = [UIColor whiteColor];
    _weatherLabel.font = [UIFont systemFontOfSize:17.f];
    [headerView addSubview:_weatherLabel];
    
    
    // 解析数据
    [self analysisData];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    CGFloat heiget = 10 + 60 + ((self.view.width - 15 * 2 - 10 * 2) / 3 * 1.5 + 20) * 2 + 60;
//    return heiget;
#if 1
    if (indexPath.row == 0) {
        CGFloat Height = (self.view.width * 0.5 + 70) * _not_missArray.count + 10 + 60;
        return Height;

    } else if (indexPath.row == 1) {
        CGFloat Heiget = 10 + 60 + ((self.view.width - 15 * 2 - 10 * 2) / 3 * 1.5 + 10) * 2 + 60;
        return Heiget;

    } else {
        CGFloat Heiget = 10 + 60 + (self.view.width - 20 * 3) / 2 * 1.5 * 2 + 20 + 60;
        return Heiget;
    }
#endif

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    static NSString *const bestWelcomeCell = @"bestWelcomeCell";
//    
//    BestWelcomeTableViewCell *cell = [_travelSiteTableView dequeueReusableCellWithIdentifier:bestWelcomeCell];
//    if (cell == nil) {
//        cell = [[BestWelcomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:bestWelcomeCell];
//    }
//    cell.most_popularArray = _most_popularArray;
//    
//    return cell;
#if 1
    if (indexPath.row == 0) {
        static NSString *const noMissCell = @"noMissCell";

        NOMissTableViewCell *cell = [_travelSiteTableView dequeueReusableCellWithIdentifier:noMissCell];
        if (cell == nil) {
            cell = [[NOMissTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:noMissCell];
        }
        cell.not_missArray = _not_missArray;
        return cell;
    } else if (indexPath.row == 1) {
        static NSString *const bestWelcomeCell = @"bestWelcomeCell";

        BestWelcomeTableViewCell *cell = [_travelSiteTableView dequeueReusableCellWithIdentifier:bestWelcomeCell];
        if (cell == nil) {
            cell = [[BestWelcomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:bestWelcomeCell];
        }
        cell.most_popularArray = _most_popularArray;
        return cell;
    } else {
        static NSString *const necessaryCell = @"necessaryCell";
        
        NecessaryTableViewCell *cell = [_travelSiteTableView dequeueReusableCellWithIdentifier:necessaryCell];
        if (cell == nil) {
            cell = [[NecessaryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:necessaryCell];
        }
        cell.local_basicArray = _local_basicArray;
        
        return cell;

    }
    
#endif
}


#pragma mark - 轮播图
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 99;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // 定位第50组
    _collectionView.contentOffset = CGPointMake(_collectionView.width * 50 * _collectionViewArray.count, 0);
    
    return _collectionViewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodprintHeadCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    
    cell.imageName = _collectionViewArray[indexPath.row];
    
    return cell;
}



- (void)timerAction:(NSTimer *)timer {
    NSInteger number = _collectionView.contentOffset.x / _collectionView.width;
    
    [_collectionView setContentOffset:CGPointMake((number + 1) * _collectionView.width, 0) animated:YES];
}

// 滑动时, 轮播图的暂停和重新开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_collectionView]) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

// 结束拖拽时, 重启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual:_collectionView]) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.0f]];
    }
}


- (void)analysisData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/place/city_index?city_id=%@&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.88274862547818&lon=121.5393111921888&page=1&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&v=1", _city_id];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            [_dataDic addEntriesFromDictionary:dataDic];
            NSArray *city_picArray = [dataDic objectForKey:@"city_pic"];
            [_collectionViewArray addObjectsFromArray:city_picArray];
            
            
            NSArray *not_missArray = [dataDic objectForKey:@"not_miss"];
            for (NSDictionary *not_missDic in not_missArray) {
                Not_MissModel *not_missModel = [[Not_MissModel alloc] initWithDic:not_missDic];
                [_not_missArray addObject:not_missModel];
            }
            
            NSArray *most_popularArray = [dataDic objectForKey:@"most_popular"];
            for (NSDictionary *most_popularDic in most_popularArray) {
                Most_PopularModel *most_popularModel = [[Most_PopularModel alloc] initWithDic:most_popularDic];
                [_most_popularArray addObject:most_popularModel];
            }
            NSArray *local_basicArray = [dataDic objectForKey:@"local_basic"];
            for (NSDictionary *local_basicDic in local_basicArray) {
                Local_BasicModel *local_basicModel = [[Local_BasicModel alloc] initWithDic:local_basicDic];
                [_local_basicArray addObject:local_basicModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _canameLabel.text = [_dataDic objectForKey:@"cnname"];
                _ennameLabel.text = [_dataDic objectForKey:@"enname"];
                NSDictionary *weatherDic = [_dataDic objectForKey:@"weather"];
                NSString *weatherText = [NSString stringWithFormat:@"%@  %@~%@", [weatherDic objectForKey:@"info"], [weatherDic objectForKey:@"low_temp"], [weatherDic objectForKey:@"high_temp"]];
                _weatherLabel.text = weatherText;
                
                [_travelSiteTableView reloadData];
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
