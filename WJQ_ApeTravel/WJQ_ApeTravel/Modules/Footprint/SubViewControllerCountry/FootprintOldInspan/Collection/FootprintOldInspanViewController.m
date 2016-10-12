//
//  FootprintOldInspanViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/6.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "FootprintOldInspanViewController.h"
#import "TravelInspanTableViewCell.h"
#import "TravelInspanModel.h"

static NSInteger numbera = 2;
static NSInteger numberb = 2;
static NSString *Cell = @"cell";
@interface FootprintOldInspanViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UILabel *pointLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tableViewArray;

@end

@implementation FootprintOldInspanViewController
- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    self.navigationItem.title = @"中国特价折扣";
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
    titleView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    [self.view addSubview:titleView];
    self.tableViewArray = [NSMutableArray array];
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(0, 0, titleView.width / 2, 45);
    [_leftButton setTitle:@"超值自由行" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000] forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:_leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(titleView.width / 2, 0, _leftButton.width, _leftButton.height);
    [_rightButton setTitle:@"精彩当地游" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:_rightButton];
    
    self.pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 3)];
    _pointLabel.center = CGPointMake(_leftButton.center.x, 43);
    _pointLabel.clipsToBounds = YES;
    _pointLabel.backgroundColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    [titleView addSubview:_pointLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, self.view.width, self.view.height - 45 - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TravelInspanTableViewCell class] forCellReuseIdentifier:Cell];
    [self.view addSubview:_tableView];
    

    
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadAMore)];
    [self asyncALoadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscountInfoViewController *discountInfoVC = [[DiscountInfoViewController alloc] init];
    TravelInspanModel *travelInspanModel = _tableViewArray[indexPath.row];
    discountInfoVC.idNumber = travelInspanModel.idNumber;
    [self.navigationController pushViewController:discountInfoVC animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelInspanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    cell.travelInspanModel = _tableViewArray[indexPath.row];
    return cell;
}

- (void)leftButtonAction:(UIButton *)leftButton {
    [self AZButton:leftButton];
    
    //默认【上拉加载】
    
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadAMore)];
    _tableView.contentOffset = CGPointMake(0, 0);
    
    [self asyncALoadData];
}

- (void)rightButtonAction:(UIButton *)rightButton {
    [self AZButton:rightButton];
    
    //默认【上拉加载】
    
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadBMore)];
    _tableView.contentOffset = CGPointMake(0, 0);
    
    [self asyncBLoadData];
}

- (void)changeButtonInfo {
    [_leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
}
- (void)AZButton:(UIButton *)azButton {
    
    [self changeButtonInfo];
    [azButton setTitleColor:[UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000] forState:UIControlStateNormal];
    azButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    _pointLabel.center = CGPointMake(azButton.center.x, 44);
    
    
    
}

// 网络请求
- (void)asyncALoadData {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/tickets_freewalker?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&id=11&lat=41.19759848641075&lon=125.6096293717715&order=2&page=1&product_type=1016%%2C1018%%2C1020&time=1&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&type=1&v=1"];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSDictionary *areaDic = [dataDic objectForKey:@"area"];
            self.navigationItem.title = [NSString stringWithFormat:@"%@特价折扣", [areaDic objectForKey:@"name"]];
            [_tableViewArray removeAllObjects];
            NSArray *listArray = [dataDic objectForKey:@"list"];
            for (NSDictionary *listDic in listArray) {
                TravelInspanModel *travelInspanModel = [[TravelInspanModel alloc] initWithDic:listDic];
                [_tableViewArray addObject:travelInspanModel];
            }
            
              dispatch_async(dispatch_get_main_queue(), ^{

                  [_tableView reloadData];
                  
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
        
    });
}

- (void)loadAMore {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/tickets_freewalker?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&id=11&lat=41.19759848641075&lon=125.6096293717715&order=2&page=%ld&product_type=1016%%2C1018%%2C1020&time=1&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&type=1&v=1", numbera];
        numbera++;
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSDictionary *areaDic = [dataDic objectForKey:@"area"];
            self.navigationItem.title = [NSString stringWithFormat:@"%@特价折扣", [areaDic objectForKey:@"name"]];
            NSArray *listArray = [dataDic objectForKey:@"list"];
            for (NSDictionary *listDic in listArray) {
                TravelInspanModel *travelInspanModel = [[TravelInspanModel alloc] initWithDic:listDic];
                [_tableViewArray addObject:travelInspanModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView.mj_footer endRefreshing];
                [_tableView reloadData];
                
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
        
    });

}

- (void)asyncBLoadData {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/local_discount?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&id=11&lat=41.19780800999999&lon=125.6096702399999&order=2&page=1&product_type=2410&time=1&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&type=1&v=1"];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSDictionary *areaDic = [dataDic objectForKey:@"area"];
            self.navigationItem.title = [NSString stringWithFormat:@"%@特价折扣", [areaDic objectForKey:@"name"]];
            [_tableViewArray removeAllObjects];
            NSArray *listArray = [dataDic objectForKey:@"list"];
            for (NSDictionary *listDic in listArray) {
                TravelInspanModel *travelInspanModel = [[TravelInspanModel alloc] initWithDic:listDic];
                [_tableViewArray addObject:travelInspanModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_tableView reloadData];
                
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
        
    });
}

- (void)loadBMore {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/local_discount?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&id=11&lat=41.19780800999999&lon=125.6096702399999&order=2&page=%ld&product_type=2410&time=1&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&type=1&v=1", numberb];
        numberb++;
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSDictionary *areaDic = [dataDic objectForKey:@"area"];
            self.navigationItem.title = [NSString stringWithFormat:@"%@特价折扣", [areaDic objectForKey:@"name"]];
            NSArray *listArray = [dataDic objectForKey:@"list"];
            for (NSDictionary *listDic in listArray) {
                TravelInspanModel *travelInspanModel = [[TravelInspanModel alloc] initWithDic:listDic];
                [_tableViewArray addObject:travelInspanModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView.mj_footer endRefreshing];
                [_tableView reloadData];
                
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
