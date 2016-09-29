//
//  DiscountViewController.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "DiscountViewController.h"
#import "Hot_AreaTableViewCell.h"

@interface DiscountViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
/**
 *  头视图 : 数据
 */
@property (nonatomic, strong) NSMutableArray *market_topicArray;
/**
 *  例如:港澳台 : 存Cell数据
 */
@property (nonatomic, strong) NSMutableArray *hotAreaArray;

/**
 *  例如:十一专场 想玩不用等 : 存Cell数据
 */
@property (nonatomic, strong) NSMutableArray *discountToArray;

/**
 *  例如:有好货 : 存Cell数据
 */
@property (nonatomic, strong) NSMutableArray *hot_goodsArray;

@end

@implementation DiscountViewController

- (void)viewWillAppear:(BOOL)animated {
    _tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.hotAreaArray = [NSMutableArray array];
    
    
    self.market_topicArray = [NSMutableArray array];
    self.discountToArray = [NSMutableArray array];

    self.hot_goodsArray = [NSMutableArray array];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    [self createSubView];
    
    [self asyncLoad];
}

- (void)createSubView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 前三个cell高度
    
    
    if (_hotAreaArray.count - 1 >= indexPath.row) {
        CGFloat Height = 10 + 60 + (self.view.width - 20 * 2 - 15 * 3) + 60;
        return Height;
    } else {
        CGFloat Width = self.view.width - 20 * 2;
        CGFloat itemWidth = (self.view.width - 20 * 2 - 15 * 3) / 4;
        CGFloat Height = 10 + 60 + Width * 0.4 + itemWidth * 1.5 * 3 + 60;
        return Height;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _discountToArray.count + _hotAreaArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_hotAreaArray.count - 1 >= indexPath.row) {
        Hot_AreaTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[Hot_AreaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        cell.hotArea = _hotAreaArray[indexPath.row];
        return cell;
    }
    
    DiscountTopicTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (cell == nil) {
        cell = [[DiscountTopicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
        
    }
    cell.discountTopicModel = _discountToArray[indexPath.row - _hotAreaArray.count];
    return cell;
#if 0
    
    
#endif
}

// 网络请求
- (void)asyncLoad {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = @"http://open.qyer.com/qyer/discount/zk/discount_index?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.8826253838339&lon=121.5392390459955&page=1&track_app_channel=App%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%25209.3.4&v=1";
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            NSArray *market_topicArray = [dataDic objectForKey:@"market_topic"];
            for (NSDictionary *market_topicDic in market_topicArray) {
                MarkettopicModel *markettopicModel = [[MarkettopicModel alloc] initWithDic:market_topicDic];
                [_market_topicArray addObject:markettopicModel];
            }
            
            
            
            NSArray *hot_areaArray = [dataDic objectForKey:@"hot_area"];
            for (NSDictionary *hot_areaDic in hot_areaArray) {
                HotArea *hotArea = [[HotArea alloc] initWithDic:hot_areaDic];
                
                [_hotAreaArray addObject:hotArea];
                
            }
            
            
            
            NSArray *discount_topicArray = [dataDic objectForKey:@"discount_topic"];
            
            for (NSDictionary *discount_topicDic in discount_topicArray) {
                DiscountTopic *discountTopicModel = [[DiscountTopic alloc] initWithDic:discount_topicDic];
                [_discountToArray addObject:discountTopicModel];
            }
            
            
            NSArray *hot_goodsArray = [dataDic objectForKey:@"hot_goods"];
            for (NSDictionary *hot_goodsDic in hot_goodsArray) {
                HotGoodsModel *hotGoodsModel = [[HotGoodsModel alloc] initWithDic:hot_goodsDic];
                [_hot_goodsArray addObject:hotGoodsModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
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
