//
//  discounCityViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/12.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "discounCityViewController.h"
#import "TypeCityTableViewCell.h"


static NSString *const Cell = @"cell";

@interface discounCityViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tableViewArray;

@end

@implementation discounCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = _idNumber;
    self.tableViewArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TypeCityTableViewCell class] forCellReuseIdentifier:Cell];
    [self.view addSubview:_tableView];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/zk/search_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&keyword=%@&lat=38.88286097141801&lon=121.5396999571838&order=&page=1&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&v=1", _idNumber];
    NSString *url = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSArray *listArray = [dataDic objectForKey:@"list"];
            [_tableViewArray removeAllObjects];
            for (NSDictionary *listDic in listArray) {
                DiscountCityListModel *listModel = [[DiscountCityListModel alloc] initWithDic:listDic];
                [_tableViewArray addObject:listModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                [_tableView reloadData];
                
            });

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    });

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscountInfoViewController *discountInfoVC = [[DiscountInfoViewController alloc] init];
    DiscountCityListModel *listModel = _tableViewArray[indexPath.row];

    discountInfoVC.idNumber = listModel.idNumber;
    [self.navigationController pushViewController:discountInfoVC animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return self.view.height / 5;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TypeCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    cell.listModel = _tableViewArray[indexPath.row];
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
