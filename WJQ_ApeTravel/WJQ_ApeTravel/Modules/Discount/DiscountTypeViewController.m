//
//  DiscountTypeViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/11.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "DiscountTypeViewController.h"
#import "TypeTableViewCell.h"


static NSString *const Cell = @"cell";

@interface DiscountTypeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
TypeTableViewCellDelegate
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableViewArray;

@end

@implementation DiscountTypeViewController

- (void)viewDidAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableViewArray = [NSMutableArray array];
    self.navigationItem.title = _titleName;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TypeTableViewCell class] forCellReuseIdentifier:Cell];
    [self.view addSubview:_tableView];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/zk/special_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.88276494355493&lon=121.5392793612916&page=1&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&type=%@&v=1", _type];
        
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *dataDic in dataArray) {
                DiscountTypeDataModel *typeModel = [[DiscountTypeDataModel alloc] initWithDic:dataDic];
                [_tableViewArray addObject:typeModel];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_tableView reloadData];
                
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            
        }];
        
    });
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CGFloat itemWidth = (self.view.width - 10 * 2 + 15 * 2) / 3;
    CGFloat itemHeight = itemWidth / 3;
    CGFloat Height = 60 + itemHeight * 3 + 10 * 2 + 20 + (self.view.width - 15 * 2) * 0.9 + 10;
    
    return Height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    cell.delegate = self;
    cell.typeModel = _tableViewArray[indexPath.row];
    return cell;
}

- (void)AZ_typeListIdNumber:(NSString *)idNumber {
    
    DiscountInfoViewController *discountInfoVC = [[DiscountInfoViewController alloc] init];
    discountInfoVC.idNumber = idNumber;
    [self.navigationController pushViewController:discountInfoVC animated:YES];
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
