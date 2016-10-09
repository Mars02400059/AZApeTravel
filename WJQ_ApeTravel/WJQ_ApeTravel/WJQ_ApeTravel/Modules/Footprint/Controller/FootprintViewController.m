//
//  FootprintViewController.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "FootprintViewController.h"
#import "AZBaseLabel.h"
#import "AZBaseButton.h"
#import "FootprintPopBournModel.h"
#import "PopBournCollectionViewCell.h"
#import "ContinentModel.h"
#import "CountryViewController.h"
#import "FootprintLineTableViewCell.h"
#import "TravelSiteViewController.h"


static NSString *const collectionViewCellIndentifier = @"collectionViewCell";

static NSString *const tableViewCellIndentifier = @"tableViewCell";

static BOOL judgeLeap = YES;

@interface FootprintViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegate,
UICollectionViewDataSource
>

// 北美洲
@property (nonatomic, strong) AZBaseButton *northAmericaButton;
// 南美洲
@property (nonatomic, strong) AZBaseButton *southAmericaButton;
// 欧洲
@property (nonatomic, strong) AZBaseButton *europeButton;
// 非洲
@property (nonatomic, strong) AZBaseButton *africaButton;
// 亚洲
@property (nonatomic, strong) AZBaseButton *asiaButton;
// 大洋洲
@property (nonatomic, strong) AZBaseButton *oceaniaButton;
// 南极洲
@property (nonatomic, strong) AZBaseButton *antarctionButton;
/// 热门目的地
@property (nonatomic, strong) UICollectionView *popBournCollectionView;
/// 其他
@property (nonatomic, strong) UITableView *restTableView;
/// 存放大洲的数组
@property (nonatomic, strong) NSMutableArray *continentArray;
/// 存放热门地区的数组
@property (nonatomic, strong) NSMutableArray *popBournArray;
/// 存放其他地区的数组
@property (nonatomic, strong) NSMutableArray *restArray;
/// 整体滑动
@property (nonatomic, strong) UIScrollView *scrollView;
/// 热门州
@property (nonatomic, strong) UILabel *popBournLabel;
/**
 *  其他州
 */
@property (nonatomic, strong) UILabel *elseLabel;

@property (nonatomic, copy) NSString *str;


@end

@implementation FootprintViewController

- (void)viewDidAppear:(BOOL)animated {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
//    self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
    
    if (judgeLeap) {
        if (self.navigationController.navigationBar.hidden) {
            _scrollView.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64 - 50);
            
        } else {
            _scrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        }

    } else {

        judgeLeap = YES;

        if (self.navigationController.navigationBar.hidden) {
            _scrollView.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
            
        } else {
            _scrollView.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
        }

        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.continentArray = [NSMutableArray array];
    self.popBournArray = [NSMutableArray array];
    self.restArray = [NSMutableArray array];
    
    
    [self createMapSubView];
}

- (void)createMapSubView {
    
    // 整个界面滑动视图
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 50)];
    self.scrollView = [[UIScrollView alloc] init];
#warning 颜色记得改 地图高度self.view.width / 1.8
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:_scrollView];
    
    // 最上部的地图
    UIImageView *mapImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"地图"]];
    mapImageView.userInteractionEnabled = YES;
    mapImageView.frame = CGRectMake(0, 0, self.view.width, self.view.width / 1.8);
    [_scrollView addSubview:mapImageView];
    
    // 地图表面的蓝魔, 用来做颜色加深
    UILabel *mapLabel = [[UILabel alloc] initWithFrame:mapImageView.bounds];
    mapLabel.backgroundColor = [UIColor colorWithRed:0.178 green:0.728 blue:0.960 alpha:0.350];
    [mapImageView addSubview:mapLabel];
    
    
    
    CGFloat width = self.view.width / 414;
    CGFloat height = self.view.height / 736;
    // 北美洲
    CGFloat northAmericaX = 55 * width;
    CGFloat northAmericaY = 50 * height;
    AZBaseLabel *northAmericaLabel = [[AZBaseLabel alloc] initWithFrame:CGRectMake(northAmericaX, northAmericaY, 10, 10)];
    [mapImageView addSubview:northAmericaLabel];
    
    self.northAmericaButton = [AZBaseButton buttonWithType:UIButtonTypeCustom];
    _northAmericaButton.number = @234;
    _northAmericaButton.x = northAmericaX - 23;
    _northAmericaButton.y = northAmericaY - 30;
    [_northAmericaButton setTitle:@"北美洲" forState:UIControlStateNormal];
    [_northAmericaButton addTarget:self action:@selector(northAmericaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [mapImageView addSubview:_northAmericaButton];
    
    
    // 南美洲
    CGFloat southAmericaX = 115 * width;
    CGFloat southAmericaY = 155 * height;
    AZBaseLabel *southAmericaLabel = [[AZBaseLabel alloc] initWithFrame:CGRectMake(southAmericaX, southAmericaY, 10, 10)];
    [mapImageView addSubview:southAmericaLabel];
    
    self.southAmericaButton = [AZBaseButton buttonWithType:UIButtonTypeCustom];
    _southAmericaButton.number = @235;
    _southAmericaButton.x = southAmericaX - 23;
    _southAmericaButton.y = southAmericaY - 30;
    [_southAmericaButton setTitle:@"南美洲" forState:UIControlStateNormal];
    [_southAmericaButton addTarget:self action:@selector(southAmericaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [mapImageView addSubview:_southAmericaButton];
    
    // 欧洲
    CGFloat europeX = 245 * width;
    CGFloat europeY = 42 * height;
    AZBaseLabel *europeLabel = [[AZBaseLabel alloc] initWithFrame:CGRectMake(europeX, europeY, 10, 10)];
    [mapImageView addSubview:europeLabel];
    
    self.europeButton = [AZBaseButton buttonWithType:UIButtonTypeCustom];
    _europeButton.number = @12;
    _europeButton.x = europeX - 23;
    _europeButton.y = europeY - 30;
    [_europeButton setTitle:@"欧洲" forState:UIControlStateNormal];
    [_europeButton addTarget:self action:@selector(europeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [mapImageView addSubview:_europeButton];
    
    // 非洲
    CGFloat africaX = 225 * width;
    CGFloat africaY = 140 * height;
    AZBaseLabel *africaLabel = [[AZBaseLabel alloc] initWithFrame:CGRectMake(africaX, africaY, 10, 10)];
    [mapImageView addSubview:africaLabel];
    
    self.africaButton = [AZBaseButton buttonWithType:UIButtonTypeCustom];
    _africaButton.number = @76;
    _africaButton.x = africaX - 23;
    _africaButton.y = africaY - 30;
    [_africaButton setTitle:@"非洲" forState:UIControlStateNormal];
    [_africaButton addTarget:self action:@selector(africaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [mapImageView addSubview:_africaButton];
    
    // 亚洲
    CGFloat asiaX = 320 * width;
    CGFloat asizY = 75 * height;
    AZBaseLabel *asiaLabel = [[AZBaseLabel alloc] initWithFrame:CGRectMake(asiaX, asizY, 10, 10)];
    [mapImageView addSubview:asiaLabel];
    
    self.asiaButton = [AZBaseButton buttonWithType:UIButtonTypeCustom];
    _asiaButton.number = @10;
    _asiaButton.click = NO;
    [_asiaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_asiaButton setBackgroundImage:[UIImage imageNamed:@"按压后气泡"]forState:UIControlStateNormal];
    _asiaButton.x = asiaX - 23;
    _asiaButton.y = asizY - 30;
    [_asiaButton addTarget:self action:@selector(asiaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_asiaButton setTitle:@"亚洲" forState:UIControlStateNormal];
    [mapImageView addSubview:_asiaButton];
    
    // 大洋洲
    CGFloat oceaniaX = 350 * width;
    CGFloat oceaniaY = 145 * height;
    AZBaseLabel *oceaniaLabel = [[AZBaseLabel alloc] initWithFrame:CGRectMake(oceaniaX, oceaniaY, 10, 10)];
    [mapImageView addSubview:oceaniaLabel];
    
    self.oceaniaButton = [AZBaseButton buttonWithType:UIButtonTypeCustom];
    _oceaniaButton.number = @239;
    _oceaniaButton.x = oceaniaX - 23;
    _oceaniaButton.y = oceaniaY - 30;
    [_oceaniaButton addTarget:self action:@selector(oceaniaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_oceaniaButton setTitle:@"大洋洲" forState:UIControlStateNormal];
    [mapImageView addSubview:_oceaniaButton];
    
    // 南极洲
    CGFloat antarctioncaX = 285 * width;
    CGFloat antarctioncaY = 210 * height;
    AZBaseLabel *antarcticaLabel = [[AZBaseLabel alloc] initWithFrame:CGRectMake(antarctioncaX, antarctioncaY, 10, 10)];
    [mapImageView addSubview:antarcticaLabel];
    
    self.antarctionButton = [AZBaseButton buttonWithType:UIButtonTypeCustom];
    _antarctionButton.number = @759;
    _antarctionButton.x = antarctioncaX - 23;
    _antarctionButton.y = antarctioncaY - 30;
    [_antarctionButton addTarget:self action:@selector(antarctionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_antarctionButton setTitle:@"南极洲" forState:UIControlStateNormal];
    [mapImageView addSubview:_antarctionButton];
    
    [self createTableViewAndCollectionView];
}

- (void)createTableViewAndCollectionView {
    
#warning 高度70
    // 热门国家
    self.popBournLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.view.width / 1.8, 200, 70)];
    _popBournLabel.font = [UIFont systemFontOfSize:20.f];
    _popBournLabel.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_popBournLabel];
    
    // 热门国家列表
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cellWidth = (self.view.width - 15 * 2 - 10) / 2;
    flowLayout.itemSize = CGSizeMake(cellWidth, cellWidth * 1.3);
    flowLayout.minimumLineSpacing = 10.f;
    flowLayout.minimumInteritemSpacing = 10.f;
    // (15, self.view.width / 1.8, self.view.width - 15 * 2, self.view.width - 64 - 50)
#warning 前两个的高度和 : self.view.width / 1.8 + 70
    self.popBournCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, self.view.width / 1.8 + 70, self.view.width - 15 * 2, self.view.width - 64 - 50) collectionViewLayout:flowLayout];
    _popBournCollectionView.backgroundColor = [UIColor whiteColor];
    _popBournCollectionView.dataSource = self;
    _popBournCollectionView.delegate = self;
//    _popBournCollectionView.layer. = NO;
    [_scrollView addSubview:_popBournCollectionView];
    [_popBournCollectionView registerClass:[PopBournCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIndentifier];
    
    
    // 其他国家
    // 纵坐标时刻在改变
    self.elseLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.width - 15, 60)];
    _elseLabel.backgroundColor = [UIColor clearColor];
    _elseLabel.textColor = [UIColor blackColor];
    _elseLabel.font = [UIFont systemFontOfSize:20.f];
    _elseLabel.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:_elseLabel];
    
    // 其他国家列表
    // tableView 纵坐标随collectionView高度变化, 不是固定的
    self.restTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 50) style:UITableViewStylePlain];
    _restTableView.rowHeight = 60.f;
    _restTableView.delegate = self;
    _restTableView.dataSource = self;
    [_scrollView addSubview:_restTableView];
    
#pragma mark - 默认进入亚洲, 初始网络请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = @"http://open.qyer.com/qyer/footprint/continent_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=A1000052A2BCDD&track_app_version=7.0.2&track_app_channel=baidu&track_device_info=PD1524B&track_os=Android5.1&app_installtime=1474192132493";
        
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            NSDictionary *dataDic = dataArray[0];
            
            // 存储当前点击选中大洲
            ContinentModel *continenModel = [[ContinentModel alloc] initWithDic:dataDic];
            [_continentArray addObject:continenModel];
            NSArray *hot_countryArray = [dataDic objectForKey:@"hot_country"];
            for (NSDictionary *hot_countryDic in hot_countryArray) {
                FootprintPopBournModel *popBournModel = [[FootprintPopBournModel alloc] initWithDic:hot_countryDic];
                [_popBournArray addObject:popBournModel];
                
            }
            NSArray *countryArray = [dataDic objectForKey:@"country"];
            for (NSDictionary *countryDic in countryArray) {
                FootprintPopBournModel *restModel = [[FootprintPopBournModel alloc] initWithDic:countryDic];
                [_restArray addObject:restModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
#warning 热门目的地

                // 刷新
                [_popBournCollectionView reloadData];
                [_restTableView reloadData];
                
            });

            
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];

    });
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    for (int i = 0; i < _continentArray.count; i++) {
        ContinentModel *continentModel = _continentArray[i];
        _popBournLabel.text = [NSString stringWithFormat:@"%@热门目的地", continentModel.cnname];
        
    }
    
    NSInteger count = _popBournArray.count;
    
    CGFloat height = (self.view.width - 15 * 2 - 10) / 2 * 1.3;
    // collectionView 的高度
    _popBournCollectionView.height = height * (count / 2 + count % 2) + (count / 2 + count % 2 - 1) * 10;
    if (_restArray.count > 0) {
        _elseLabel.y = self.view.width / 1.8 + 70 + _popBournCollectionView.height;
        for (int i = 0; i < _continentArray.count; i++) {
            ContinentModel *continentModel = _continentArray[i];
            _elseLabel.text = [NSString stringWithFormat:@"%@其他目的地 (拼音首字母排序)", continentModel.cnname];
            
        }
        
    }
    // 设置tableView纵坐标
    _restTableView.y = self.view.width / 1.8 + 70 + 60 + _popBournCollectionView.height;
    NSInteger tableCount = _restArray.count;
    _restTableView.height = 60 * tableCount;
    
    _scrollView.contentSize = CGSizeMake(0, self.view.width / 1.8 + 70 + 60 + _popBournCollectionView.height + _restTableView.height);

    return _popBournArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PopBournCollectionViewCell *cell = [_popBournCollectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIndentifier forIndexPath:indexPath];
    
    FootprintPopBournModel *popBournModel = _popBournArray[indexPath.row];
    cell.popBournModel = popBournModel;


    return cell;
}
// collectionView 页面跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    
    judgeLeap = NO;
    
    FootprintPopBournModel *popBournModel = _popBournArray[indexPath.row];
    ContinentModel *continentModel = _continentArray[0];
    if (popBournModel.flag == 1) {
        CountryViewController *countryVC = [[CountryViewController alloc] init];
        
        // 选择的大洲
        countryVC.oblastID = continentModel.oblastID;
        // 点击的国家
        countryVC.countryID = popBournModel.countryID;
        [self.navigationController pushViewController:countryVC animated:YES];
    } else {
        TravelSiteViewController *travelSiteView = [[TravelSiteViewController alloc] init];
        travelSiteView.city_id = popBournModel.countryID;
        [self.navigationController pushViewController:travelSiteView animated:YES];
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _restArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
   
    FootprintLineTableViewCell *cell = [_restTableView dequeueReusableCellWithIdentifier:tableViewCellIndentifier];
    if (nil == cell) {
        cell = [[FootprintLineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewCellIndentifier];
    }
    FootprintPopBournModel *restModel = _restArray[indexPath.row];
    
    cell.textLabel.text = restModel.cnname;
    cell.detailTextLabel.text = restModel.enname;
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.627 alpha:1.000];
    return cell;
    
    
}
// tableView页面跳转

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    
    judgeLeap = NO;

    
    FootprintPopBournModel *restModel = _restArray[indexPath.row];
    ContinentModel *continentModel = _continentArray[0];
    if (restModel.flag == 1) {
        CountryViewController *countryVC = [[CountryViewController alloc] init];
        
        // 选择的大洲
        countryVC.oblastID = continentModel.oblastID;
        // 点击的国家
        countryVC.countryID = restModel.countryID;
        [self.navigationController pushViewController:countryVC animated:YES];
    } else {
        TravelSiteViewController *travelSiteVC = [[TravelSiteViewController alloc] init];
        travelSiteVC.city_id = restModel.countryID;
        [self.navigationController pushViewController:travelSiteVC animated:YES];

    
    }
    
}


// 北美洲点击事件
- (void)northAmericaButtonAction:(AZBaseButton *)northAmericaButton {

    [self WJQ_changeAlveoliAZBaseButton:northAmericaButton];
}
// 南美洲点击事件
- (void)southAmericaButtonAction:(AZBaseButton *)southAmericaButton {
    
    [self WJQ_changeAlveoliAZBaseButton:southAmericaButton];
}
// 欧洲点击事件
- (void)europeButtonAction:(AZBaseButton *)europeButton {
    
    [self WJQ_changeAlveoliAZBaseButton:europeButton];
}
// 非洲点击事件
- (void)africaButtonAction:(AZBaseButton *)africaButton {
    
    [self WJQ_changeAlveoliAZBaseButton:africaButton];
}
// 亚洲点击事件
- (void)asiaButtonAction:(AZBaseButton *)asiaButton {
    
    [self WJQ_changeAlveoliAZBaseButton:asiaButton];
}
// 大洋洲点击事件
- (void)oceaniaButtonAction:(AZBaseButton *)oceaniaButton {
    
    [self WJQ_changeAlveoliAZBaseButton:oceaniaButton];
}
// 南极洲点击事件
- (void)antarctionButtonAction:(AZBaseButton *)antarctionButton {
    
    [self WJQ_changeAlveoliAZBaseButton:antarctionButton];
}
// 变化气泡, 点击加载变换数据
- (void)WJQ_changeAlveoliAZBaseButton:(AZBaseButton *)AZBaseButton {

    // 判断按钮是否处于选中状态, 当按钮处于没有选中时可进入此方法
    if (AZBaseButton.click) {
         // 将所有的按钮变回没有选中的状态
         if (AZBaseButton.clickTwo) {
             [_northAmericaButton setBackgroundImage:[UIImage imageNamed:@"气泡"]forState:UIControlStateNormal];
             [_northAmericaButton setTitleColor:[UIColor colorWithWhite:0.476 alpha:1.000] forState:UIControlStateNormal];
             _northAmericaButton.click = YES;
             [_southAmericaButton setBackgroundImage:[UIImage imageNamed:@"气泡"]forState:UIControlStateNormal];
             [_southAmericaButton setTitleColor:[UIColor colorWithWhite:0.476 alpha:1.000] forState:UIControlStateNormal];
             _southAmericaButton.click = YES;
             [_europeButton setBackgroundImage:[UIImage imageNamed:@"气泡"]forState:UIControlStateNormal];
             [_europeButton setTitleColor:[UIColor colorWithWhite:0.476 alpha:1.000] forState:UIControlStateNormal];
             _europeButton.click = YES;
             [_africaButton setBackgroundImage:[UIImage imageNamed:@"气泡"]forState:UIControlStateNormal];
             [_africaButton setTitleColor:[UIColor colorWithWhite:0.476 alpha:1.000] forState:UIControlStateNormal];
             _africaButton.click = YES;
             [_asiaButton setBackgroundImage:[UIImage imageNamed:@"气泡"]forState:UIControlStateNormal];
             [_asiaButton setTitleColor:[UIColor colorWithWhite:0.476 alpha:1.000] forState:UIControlStateNormal];
             _asiaButton.click = YES;
             [_oceaniaButton setBackgroundImage:[UIImage imageNamed:@"气泡"]forState:UIControlStateNormal];
             [_oceaniaButton setTitleColor:[UIColor colorWithWhite:0.476 alpha:1.000] forState:UIControlStateNormal];
             _oceaniaButton.click = YES;
             [_antarctionButton setBackgroundImage:[UIImage imageNamed:@"气泡"]forState:UIControlStateNormal];
             [_antarctionButton setTitleColor:[UIColor colorWithWhite:0.476 alpha:1.000] forState:UIControlStateNormal];
             _antarctionButton.click = YES;

         }
         // 将当前点击的按钮置成选中状态
        [AZBaseButton setBackgroundImage:[UIImage imageNamed:@"按压后气泡"] forState:UIControlStateNormal];
        [AZBaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        AZBaseButton.click = NO;
        [_continentArray removeAllObjects];
        [_popBournArray removeAllObjects];
        [_restArray removeAllObjects];
#pragma mark - 点击按钮换取大洲, 刷新网络请求
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSString *url = @"http://open.qyer.com/qyer/footprint/continent_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=A1000052A2BCDD&track_app_version=7.0.2&track_app_channel=baidu&track_device_info=PD1524B&track_os=Android5.1&app_installtime=1474192132493";
            [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSArray *dataArray = [responseObject objectForKey:@"data"];
                for (NSDictionary *dataDic in dataArray) {
#pragma bug 点击过国家后不能更换大洲
                    if ([AZBaseButton.number isEqualToNumber:[dataDic objectForKey:@"id"]]) {
                        
                        // 存储当前点击选中大洲
                        ContinentModel *continetModel = [[ContinentModel alloc] initWithDic:dataDic];
                        
                        [_continentArray addObject:continetModel];
                        
                        NSArray *hot_countryArray = [dataDic objectForKey:@"hot_country"];
                        for (NSDictionary *hot_countryDic in hot_countryArray) {
                            FootprintPopBournModel *popBournModel = [[FootprintPopBournModel alloc] initWithDic:hot_countryDic];
                            
                            [_popBournArray addObject:popBournModel];
                            
                        }
                        NSArray *countryArray = [dataDic objectForKey:@"country"];
                        for (NSDictionary *countryDic in countryArray) {
                            FootprintPopBournModel *restModel = [[FootprintPopBournModel alloc] initWithDic:countryDic];
                            [_restArray addObject:restModel];
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            // 刷新
                            [_popBournCollectionView reloadData];
                            [_restTableView reloadData];
                            
                        });
                    }
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error : %@", error);
            }];
            
        });


        
         
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
