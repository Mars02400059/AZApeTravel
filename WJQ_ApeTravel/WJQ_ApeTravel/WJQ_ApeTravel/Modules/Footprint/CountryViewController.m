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

@interface CountryViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate
>

/**
 *  整个页面
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 *  判断时候做动画的参数
 */
@property (nonatomic, assign) BOOL use;
/**
 *  存数据国家
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

@end

@implementation CountryViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.use = YES;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modelArray = [NSMutableArray array];
    self.cityInfoArray = [NSMutableArray array];
    self.inspanInfoArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 40) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 110.f;
    _tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tableView];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_id=%@&lat=38.88269136659446&lon=121.5392352265454&page=1&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&v=1", _number];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            
            CountryModel *countryModel = [[CountryModel alloc] initWithDic:dataDic];
            [_modelArray addObject:countryModel];
            NSArray *hot_cityArray = [dataDic objectForKey:@"hot_city"];
            for (NSDictionary *hot_cityDic in hot_cityArray) {
                CityModel *cityModel = [[CityModel alloc] initWithDic:hot_cityDic];
                [_cityInfoArray addObject:cityModel];
    
            }
          
            
            NSArray *new_discountArray = [dataDic objectForKey:@"new_discount"];
            for (NSDictionary *new_discountDic in new_discountArray) {
                TravelInspanModel *travelInspanModel = [[TravelInspanModel alloc] initWithDic:new_discountDic];
                [_inspanInfoArray addObject:travelInspanModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
           
                [_tableView reloadData];
            });

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];

        
    });

    
    
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _inspanInfoArray.count;
//    if (0 == section) {
//        return _cityInfoArray.count;
//    } else {
//        return _inspanInfoArray.count;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const tableViewCell = @"cell";
    TravelInspanTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:tableViewCell];
    if (nil == cell) {
        cell = [[TravelInspanTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewCell];
    }
    TravelInspanModel *travelInspanModel = _inspanInfoArray[indexPath.row];
    cell.travelInspanModel = travelInspanModel;
    return cell;
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
