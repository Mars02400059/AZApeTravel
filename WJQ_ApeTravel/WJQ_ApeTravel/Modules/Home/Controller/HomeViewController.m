//
//  HomeViewController.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "HomeOneTableViewCell.h"
#import "HomeTwoTableViewCell.h"
#import "HomeThreeTableViewCell.h"
#import "HomeSlideModel.h"
#import "SlideCollectionViewCell.h"
#import "CommendView.h"
#import "JumpViewController.h"
#import "TravelSiteViewController.h"
static NSString *const collectionCell = @"cell";

static NSInteger number = 2;
@interface HomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate,
CommendViewDelegate
>
@property (nonatomic, strong) NSMutableArray *tableViewArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;
// 定时器
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *collectionViewArray;
@property (nonatomic, strong) CommendView *commendView;
// 时候可以执行动画
@property (nonatomic, assign) BOOL use;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation HomeViewController

// 视图将要出现
- (void)viewWillAppear:(BOOL)animated {

    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    self.navigationController.navigationBar.hidden = YES;
    self.use = YES;
}
#if 0

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (_tableView.contentOffset.y >= (_collectionView.height) && _use == YES) {
        [UIView animateWithDuration:0.01 animations:^{
            _use = NO;
            self.navigationController.navigationBar.hidden = NO;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
            _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        } completion:nil];
    }
    
    if (_tableView.contentOffset.y < _collectionView.height && _use == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            _use = YES;
            self.navigationController.navigationBar.hidden = YES;
            _tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        } completion:nil];
    }
    
}

#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 在视图将要出现时写navigationBar状态
//    self.navigationController.navigationBar.hidden = NO;
    


    
    [self createSubView];
    
    
    
}





- (void)createSubView {

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50) style:UITableViewStylePlain];
//    _tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64 - 50);
    _tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.000];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    // 头视图
    [self createSlideView];
    
    self.tableViewArray = [NSMutableArray array];
    
    
    // 网络请求 + 解析数据
    
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(asyncLoadData)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];

    
    [self asyncLoadData];


}


#pragma mark - 头视图部分

- (void)createSlideView {
#warning 高度要改
    
    // 最后一个图片高度60 y 5
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, _tableView.width / 2 + 55 + 10 + _tableView.width - 65 + 40 + 10 + 50)];
    
    headerView.height = _tableView.width / 2 + 10 + _tableView.width - 65 + 50;
    
    
    headerView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.000];
    _tableView.tableHeaderView = headerView;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(headerView.bounds.size.width,  headerView.bounds.size.width / 2);
    flowLayout.minimumLineSpacing = 0.f;
    flowLayout.minimumInteritemSpacing = 0.f;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
#pragma mark - 轮播图
    self.collectionViewArray = [NSMutableArray array];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.width / 2) collectionViewLayout:flowLayout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:_collectionView];
    [_collectionView registerClass:[SlideCollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
    
#pragma mark == page设置
    self.pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = _collectionViewArray.count;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.766 alpha:1.000];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.hidesForSinglePage = YES;
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:_pageControl];
    
    if (_timer) {
        [_timer invalidate];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:7.0f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
#pragma mark - 头视图搜索框
    
    UIView *upView = [[UIView alloc] init];
    upView.x = 0.f;
    upView.y = _collectionView.height;
    upView.width = headerView.width;
    upView.height = 55.f;
    upView.backgroundColor = [UIColor yellowColor];
//    [headerView addSubview:upView];
    
#pragma mark - 头视图推荐部分
    
    CGFloat commendViewY = _collectionView.bounds.size.height + 65;
    CGFloat commendViewWidth = headerView.bounds.size.width - 10 * 2;
    CGFloat commendViewHeihet = headerView.bounds.size.width - 65;
    self.commendView = [[CommendView alloc] initWithFrame:CGRectMake(10, commendViewY, commendViewWidth, commendViewHeihet)];
    
    
    _commendView.y = commendViewY - 55;
    
    
    _commendView.delegate = self;
    _commendView.layer.cornerRadius = 7.f;
    [_commendView.layer setBorderWidth:1.0f];
    _commendView.layer.borderColor = [UIColor colorWithWhite:0.736 alpha:1.000].CGColor;
    _commendView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:_commendView];
    
#pragma mark - 点评, 需要登录
    
    UIView *downView = [[UIView alloc] init];
    downView.x = 10;
    downView.y = commendViewY + commendViewHeihet + 10;
    downView.width = _commendView.width;
    downView.height = 40;
    downView.backgroundColor = [UIColor redColor];
//    [headerView addSubview:downView];
    
    // 没有用的, 观赏图
    UIImageView *poraryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"占位"]];
    poraryImageView.frame = CGRectMake((headerView.width - 80) / 2, downView.y + downView.height + 5, 80, 60);
    [headerView addSubview:poraryImageView];
    
    poraryImageView.y = commendViewY - 55 + commendViewHeihet;
    


    [self getNetworkData];
}




- (void)getNetworkData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = @"http://open.qyer.com/qyer/home/home_city_info?city_ids=9492%2C31%2C68%2C63&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&lat=38.8827003902727&lng=121.5392975581395&page=1&track_app_channel=App%2520Store&track_app_version=7.0.1&track_device_info=iPad%2520mini%2520%28Wifi%29&track_deviceid=AE6FB093-3107-447D-8CAE-5A460F8A747A&track_os=ios%25209.3.5&v=1";
        
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [AZType AZTypeCacensWritePatchCachePatch:@"homecommendView.plist" cacheDic:responseObject];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _commendView.dataDic = [responseObject objectForKey:@"data"];
                
                
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            AZType *azType = [AZType new];
            NSDictionary *responseObject = [azType AZTypeGetTakeCachePatch:@"homecommendView.plist"];
            _commendView.dataDic = [responseObject objectForKey:@"data"];
            
        }];
        
    });
}



#pragma mark - 协议传值, 跳转页面

- (void)AZ_DeliverCity_ID:(NSString *)city_id {
    
    TravelSiteViewController *travelSiteVC = [[TravelSiteViewController alloc] init];
    travelSiteVC.hidesBottomBarWhenPushed = YES;
    travelSiteVC.city_id = city_id;
    [self.navigationController pushViewController:travelSiteVC animated:YES];
    
}

- (void)AZ_deliverButtonCityID:(NSString *)buttonCityID {
    TravelSiteViewController *travelSiteVC = [[TravelSiteViewController alloc] init];
    travelSiteVC.city_id = buttonCityID;
    travelSiteVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:travelSiteVC animated:YES];

}

#pragma mark - 轮播图
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 99;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    确定page的大小位置
    CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_collectionViewArray.count];
    CGPoint pageControlOrigin = {(_collectionView.width - pageControlSize.width) / 2, _collectionView.height - pageControlSize.height};
    CGRect pageControlFrame = {pageControlOrigin, pageControlSize};
    _pageControl.frame = pageControlFrame;
    _pageControl.numberOfPages = _collectionViewArray.count;
    return _collectionViewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SlideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    HomeSlideModel *homeSlideModel = _collectionViewArray[indexPath.row];
    cell.homeSlideModel = homeSlideModel;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeSlideModel *homeSlideModel = _collectionViewArray[indexPath.row];
    JumpViewController *jumpVC = [[JumpViewController alloc] init];
    jumpVC.url = homeSlideModel.url;
    jumpVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jumpVC animated:YES];

}

- (void)timerAction:(NSTimer *)timer {
    NSInteger number = _collectionView.contentOffset.x / _collectionView.width;
    // 当前图片为第几张图片
    
    NSInteger pageNumber = 0;
    if (0 != _collectionViewArray.count) {
        pageNumber = (number + 1) % _collectionViewArray.count;
    }
    
    
    [_collectionView setContentOffset:CGPointMake((number + 1) * _collectionView.width, 0) animated:YES];
    if (pageNumber == 0) {
        _pageControl.currentPage = 0;
    }
    _pageControl.currentPage = pageNumber;
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_collectionView]) {
        // 求是第几张图片
        NSInteger number = scrollView.contentOffset.x / scrollView.width;
        NSInteger imageNumber = number % _collectionViewArray.count;
        // 使page位置与图片关联
        NSInteger pageNumber = imageNumber;
        _pageControl.currentPage = pageNumber;
    }
}
// 初始偏移量
// _collectionView.bounds.size.width * _collectionViewArray.count * 50

#warning 每次点击回到第50组图片, 图片闪动太大
- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    [_collectionView setContentOffset:CGPointMake((pageControl.currentPage + 1) * _collectionView.width + _collectionView.width * _collectionViewArray.count * 50 - _collectionView.width, 0) animated:YES];
}


#pragma mark - TableView


/// 调节高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    /// 第一种高度
//    tableView.rowHeight = 370;
//    /// 第二种高度
//    tableView.rowHeight = 380;
//    /// 第三种高度
//    tableView.rowHeight = 370.f;
//    /// 第四种高度
//    tableView.rowHeight = 420;
    /// 高度全部加15点, 留出空白部分
    HomeModel *homeModel = _tableViewArray[indexPath.row];
    if (1 == homeModel.type && 0 == homeModel.author.count) {
        return 385.f;
    } else if (2 == homeModel.type) {
        return 385.f;
    } else if (3 == homeModel.type) {
        return 435.f;
    } else {
        return 420.f;
    }
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *homeModel = _tableViewArray[indexPath.row];
    
    //http://pic.qyer.com/public/2016/09/23/57e4aa191e27c.jpg?imageView2/1/w/800/h/450/format/webp/710x360
    
    
#if 1
    if (1 == homeModel.type && 0 == homeModel.author.count) {
        static NSString *const cell1Indetofier = @"cell1";
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell1Indetofier];
        if (nil == cell) {
            cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell1Indetofier];
        }
        
        cell.homeModel = homeModel;
        return cell;
    } else if (2 == homeModel.type) {
        static NSString *const cell2Indetofier = @"cell2";
        HomeTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell2Indetofier];
        if (nil == cell) {
            cell = [[HomeTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell2Indetofier];
        }
        cell.homeModel = homeModel;
        return cell;
    } else if (3 == homeModel.type) {
        static NSString *const cell3Indetofier = @"cell3";
        HomeThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell3Indetofier];
        if (nil == cell) {
            cell = [[HomeThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell3Indetofier];
        }
        cell.homeModel = homeModel;
        
        return cell;
    }  else {
        static NSString *const cell4Indetofier = @"cell4";
        HomeOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell4Indetofier];
        if (nil == cell) {
            cell = [[HomeOneTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell4Indetofier];
        }
        cell.homeModel = homeModel;
        return cell;
    }
#endif
}
#pragma mark - tableViewCell点跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel *homeModel = _tableViewArray[indexPath.row];
    
    JumpViewController *jumpVC = [[JumpViewController alloc] init];
    jumpVC.url = homeModel.url;
    jumpVC.title = homeModel.title;
    jumpVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jumpVC animated:YES];
    
}
// 网络请求
- (void)asyncLoadData {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/home/home_feed?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=A1000052A2BCDD&track_app_version=7.0.2&track_app_channel=baidu&track_device_info=PD1524B&track_os=Android5.1&app_installtime=1474192132493&page=1"];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [AZType AZTypeCacensWritePatchCachePatch:@"homeController.plist" cacheDic:responseObject];
            
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            
            NSArray *slideArray = [dataDic objectForKey:@"slide"];
            [_collectionViewArray removeAllObjects];
            for (NSDictionary *slideDic in slideArray) {
                HomeSlideModel *homeSlideModel = [[HomeSlideModel alloc] initWithDic:slideDic];
                [_collectionViewArray addObject:homeSlideModel];
            }
            
            [_tableViewArray removeAllObjects];
            NSDictionary *feedDic = [dataDic objectForKey:@"feed"];
            NSArray *entryArray = [feedDic objectForKey:@"entry"];
            for (NSDictionary *entryDic in entryArray) {
                HomeModel *homeModel = [[HomeModel alloc] initWithDic:entryDic];
                [_tableViewArray addObject:homeModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                // 设置偏移量, 定位到第50组
                _collectionView.contentOffset = CGPointMake(_collectionView.bounds.size.width * _collectionViewArray.count * 50, 0);
                
                [_collectionView reloadData];
                
                [_tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            });

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            AZType *azType = [AZType new];
            NSDictionary *responseObject = [azType AZTypeGetTakeCachePatch:@"homeController.plist"];
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                
                NSArray *slideArray = [dataDic objectForKey:@"slide"];
                [_collectionViewArray removeAllObjects];
                for (NSDictionary *slideDic in slideArray) {
                    HomeSlideModel *homeSlideModel = [[HomeSlideModel alloc] initWithDic:slideDic];
                    [_collectionViewArray addObject:homeSlideModel];
                }
                
                [_tableViewArray removeAllObjects];
                NSDictionary *feedDic = [dataDic objectForKey:@"feed"];
                NSArray *entryArray = [feedDic objectForKey:@"entry"];
                for (NSDictionary *entryDic in entryArray) {
                    HomeModel *homeModel = [[HomeModel alloc] initWithDic:entryDic];
                    [_tableViewArray addObject:homeModel];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 设置偏移量, 定位到第50组
                    _collectionView.contentOffset = CGPointMake(_collectionView.bounds.size.width * _collectionViewArray.count * 50, 0);
                    
                    [_collectionView reloadData];
                    
                    [_tableView reloadData];
                    [self.tableView.mj_header endRefreshing];
                });

                
            });

            
            
        }];
        
        
    });
}

- (void)loadMore {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/home/home_feed?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=A1000052A2BCDD&track_app_version=7.0.2&track_app_channel=baidu&track_device_info=PD1524B&track_os=Android5.1&app_installtime=1474192132493&page=%ld", number];
        number++;
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];

            
#pragma mark - cell部分数据
            NSDictionary *feedDic = [dataDic objectForKey:@"feed"];
            NSArray *entryArray = [feedDic objectForKey:@"entry"];
            for (NSDictionary *entryDic in entryArray) {
                HomeModel *homeModel = [[HomeModel alloc] initWithDic:entryDic];
                [_tableViewArray addObject:homeModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                // 设置偏移量, 定位到第50组
                [_tableView reloadData];
                [self.tableView.mj_footer endRefreshing];
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

@end
