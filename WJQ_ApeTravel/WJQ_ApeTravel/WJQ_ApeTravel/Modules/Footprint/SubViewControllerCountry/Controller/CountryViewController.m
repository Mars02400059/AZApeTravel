//
//  CountryViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/26.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "CountryViewController.h"
#import "CountryModel.h"
#import "CityModel.h"
#import "TravelInspanModel.h"
#import "TravelInspanTableViewCell.h"
#import "TravelInspanModel.h"
#import "FoodprintHeadCollectionViewCell.h"
#import "LookAllTableViewCell.h"
#import "FootprintCollectionTableViewCell.h"
#import "LookAllTwoTableViewCell.h"

static NSString *const collectionCell = @"collectionCell";

@interface CountryViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
FootprintCollectionTableViewCellDelegate,
LookAllTableViewCellDelegate,
LookAllTwoTableViewCellDataSource
>



/**
 *  整个界面
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 *  按钮, (添加, 结伴, 问答)
 */
@property (nonatomic, strong) UIView *buttonView;
/**
 *  判断时候做动画的参数
 */
@property (nonatomic, assign) BOOL use;
/**
 *  存数据,国家
 */
@property (nonatomic, strong) NSMutableArray *modelArray;
/**
 *  存储城市信息
 */
@property (nonatomic, strong) NSMutableArray *cityInfoArray;
/**
 *  存储套餐信息
 */
@property (nonatomic, strong) NSMutableArray *inspanInfoArray;
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

@property (nonatomic, strong) UILabel *entryContLabel;

@end

@implementation CountryViewController

- (void)viewWillAppear:(BOOL)animated {
    
    /**
     * 导航栏效果
     */
    self.navigationController.navigationBar.hidden = YES;
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.use = YES;

    // 调整透明度
//    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;

}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    
//    if (_tableView.contentOffset.y > 10 && _use == YES) {
//        NSLog(@"hahahhah");
//        [UIView animateWithDuration:0.5 animations:^{
//            _use = NO;
//            self.navigationController.navigationBar.hidden = NO;
//            
//        } completion:nil];
//    }
//    
//    if (_tableView.contentOffset.y <= 10 && _use == NO) {
//        [UIView animateWithDuration:0.5 animations:^{
//            _use = YES;
//            self.navigationController.navigationBar.hidden = YES;
//            
//        } completion:nil];
//    }
//    
//}
// 页面完全出现



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.modelArray = [NSMutableArray array];
    self.cityInfoArray = [NSMutableArray array];
    self.inspanInfoArray = [NSMutableArray array];
    self.collectionViewArray = [NSMutableArray array];
    
    // 整个界面的tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
#pragma mark - 已登录相关的底部按钮
    // tableView下方的按钮
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 50, self.view.width, 50)];
    _buttonView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_buttonView];
    
    // 头视图, 放轮播图以及国家,英文名, 简介
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, _tableView.width * 0.65)];
    headerView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.000];
    _tableView.tableHeaderView = headerView;
#pragma mark - 轮播图

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(headerView.width,  headerView.height);
    flowLayout.minimumLineSpacing = 0.f;
    flowLayout.minimumInteritemSpacing = 0.f;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height) collectionViewLayout:flowLayout];
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
    self.canameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _collectionView.height / 2, 100, 40)];
    _canameLabel.textColor = [UIColor whiteColor];
    _canameLabel.font = [UIFont systemFontOfSize:22.f];
    [headerView addSubview:_canameLabel];
    
    // 国家名, 英文
    self.ennameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _collectionView.height / 2 + 35, 70, 30)];
    _ennameLabel.font = [UIFont systemFontOfSize:18.f];
    _ennameLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:_ennameLabel];
    
    // 简介
    self.entryContLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _collectionView.height * 3 / 4, _collectionView.width - 20 * 2, _collectionView.height * 1 / 4 - 15)];
    _entryContLabel.numberOfLines = 2;
    _entryContLabel.font = [UIFont systemFontOfSize:16.f];
    _entryContLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:_entryContLabel];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=%@&country_id=%@&lat=38.88269136659446&lon=121.5392352265454&page=1&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&v=1", _oblastID, _countryID];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            
            CountryModel *countryModel = [[CountryModel alloc] initWithDic:dataDic];
            [_modelArray addObject:countryModel];
            NSArray *photos = [dataDic objectForKey:@"photos"];
            
            /**
             *  存轮播图图片
             */
            for (NSString *imageName in photos) {
                [_collectionViewArray addObject:imageName];
            }
            
            /**
             *  存国家热门城市数据
             */
            NSArray *hot_cityArray = [dataDic objectForKey:@"hot_city"];
            for (NSDictionary *hot_cityDic in hot_cityArray) {
                CityModel *cityModel = [[CityModel alloc] initWithDic:hot_cityDic];
                [_cityInfoArray addObject:cityModel];
    
            }

            /**
             *  存超值自由行数据
             */
            NSArray *new_discountArray = [dataDic objectForKey:@"new_discount"];
            for (NSDictionary *new_discountDic in new_discountArray) {
                TravelInspanModel *travelInspanModel = [[TravelInspanModel alloc] initWithDic:new_discountDic];
                [_inspanInfoArray addObject:travelInspanModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                for (int i = 0; i < _modelArray.count; i++) {
                    CountryModel *countryModel = _modelArray[i];
                    
                    // 给头视图上面的三个label赋值
                    _canameLabel.text = countryModel.cnname;
                    _ennameLabel.text = countryModel.enname;
                    _entryContLabel.text = countryModel.entryCont;
                }
                [_collectionView reloadData];
                [_tableView reloadData];
            });

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];

        
    });

    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 当存储超值自由行的数组为空时, tableView只有两个Cell
    if (_inspanInfoArray.count == 0) {
        // cell的高度
        if (0 == indexPath.row) {
            return 60.f;
        } else {
            CGFloat height = 10 + 10 + 15 + 2 * ( 0.6 * ((self.view.width - 15 * 2 - 10) / 2));
            return height;
        }
    // 当存储超值自由行的数组不为空时, tableView有5个Cell
    } else {
    
        // cell高度
        
        // 两种查看全部按钮的高度
        if (0 == indexPath.row || 2== indexPath.row) {
            return 60.f;
        // cell中为四张图片
        } else if (1 == indexPath.row) {
            CGFloat height = 10 + 10 + 15 + 2 * ( 0.6 * ((self.view.width - 15 * 2 - 10) / 2));
            return height;
        
        } else {
            return 110.f;
        }
    
    }
    

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 当存储超值自由行的数组为空时, tableView只有两个Cell
    if (_inspanInfoArray.count == 0) {
        return 2;
    }
    
    // 当存储超值自由行的数组不为空时, tableView有5个Cell
    return _inspanInfoArray.count + 3;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 当存储超值自由行的数组为空时, tableView只有两个Cell
    if (_inspanInfoArray.count == 0) {
        
        if (0 == indexPath.row) {
            LookAllTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"lookAllCell1"];
            cell.delegate = self;
            if (nil == cell) {
                cell = [[LookAllTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"lookAllCell1"];
            }
            for (int i = 0; i < _modelArray.count; i++) {
                CountryModel *countryModel = _modelArray[i];
                NSString *labelText = [NSString stringWithFormat:@"%@城市", countryModel.cnname];
                cell.labelText = labelText;
                
            }
            
            return cell;
        } else {
            FootprintCollectionTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (nil == cell) {
                cell = [[FootprintCollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
            }
            cell.delegate = self;
            cell.hot_cityArray = _cityInfoArray;
            return cell;
        }
        
    // 当存储超值自由行的数组不为空时, tableView有n个Cell

    } else {
        
        if (0 == indexPath.row) {
            LookAllTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"lookAllCell1"];
            cell.delegate = self;
            if (nil == cell) {
                cell = [[LookAllTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"lookAllCell1"];
            }
            for (int i = 0; i < _modelArray.count; i++) {
                CountryModel *countryModel = _modelArray[i];
                NSString *labelText = [NSString stringWithFormat:@"%@城市", countryModel.cnname];
                cell.labelText = labelText;
                
            }
            return cell;
        } else if (1 == indexPath.row) {
            FootprintCollectionTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (nil == cell) {
                cell = [[FootprintCollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
            }
            cell.hot_cityArray = _cityInfoArray;
            return cell;
        } else if (2 == indexPath.row) {
            LookAllTwoTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"lookAllTwoCell"];
            if (nil == cell) {
                cell = [[LookAllTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"lookAllTwoCell"];
            }
            cell.dataSource = self;
            cell.labelText = @"超值自由行";
            return cell;
        } else {
            static NSString *const travelInspanCell = @"travelInspanCell";
            TravelInspanTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:travelInspanCell];
            if (nil == cell) {
                cell = [[TravelInspanTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:travelInspanCell];
            }
            TravelInspanModel *travelInspanModel = _inspanInfoArray[indexPath.row - 3];
            cell.travelInspanModel = travelInspanModel;
            return cell;
        }

    
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_inspanInfoArray.count > 0) {
        if (indexPath.row > 2) {
            
        }
    }
}

- (void)AZ_transmitInfoAndSpringCityPageTable {
    OldCityViewController *oldCityVC = [[OldCityViewController alloc] init];
    oldCityVC.oblastID = _oblastID;
    oldCityVC.countryID = _countryID;
    [self.navigationController pushViewController:oldCityVC animated:YES];
}

- (void)AZ_transmitInfoAndSpringInspanPageTable {
    FootprintOldInspanViewController *inspanVC = [[FootprintOldInspanViewController alloc] init];
    inspanVC.oblastID = _oblastID;
    inspanVC.countryID = _countryID;
    [self.navigationController pushViewController:inspanVC animated:YES];
}

- (void)AZ_SelectedIDNumber:(NSString *)idNumber {
    TravelSiteViewController *travelSiteVC = [[TravelSiteViewController alloc] init];
    travelSiteVC.city_id = idNumber;
    [self.navigationController pushViewController:travelSiteVC animated:YES];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
