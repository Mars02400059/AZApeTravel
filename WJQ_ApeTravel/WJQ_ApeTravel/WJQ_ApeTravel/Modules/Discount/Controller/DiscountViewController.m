//
//  DiscountViewController.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "DiscountViewController.h"
#import "Hot_AreaTableViewCell.h"
#import "DiscountButtonView.h"

@interface DiscountViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
Hot_AreaTableViewCellDelegate,
DiscountTopicTableViewCellDelegate,
HotGoodTableViewCellDelegate
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

@property (nonatomic, strong) UIImageView *headerViewLeftImage;

@property (nonatomic, strong) UIImageView *headerViewRaghtTopImage;

@property (nonatomic, strong) UIImageView *headerViewRaghtDownImage;

@end

@implementation DiscountViewController

- (void)viewWillAppear:(BOOL)animated {
//    _tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    
    self.tabBarController.tabBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.hotAreaArray = [NSMutableArray array];
    self.hot_goodsArray = [NSMutableArray array];

    
    self.market_topicArray = [NSMutableArray array];
    self.discountToArray = [NSMutableArray array];


    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    [self createSubView];
    
    [self asyncLoad];
}

- (void)createSubView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width * 1)];
//    headerView.backgroundColor = [UIColor redColor];
    _tableView.tableHeaderView = headerView;
    
    CGFloat buttonWidth = headerView.width - 10 * 2;
    CGFloat buttonHeight = headerView.height * 0.55;
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, buttonWidth, buttonHeight)];
//    buttonView.backgroundColor = [UIColor yellowColor];
    [headerView addSubview:buttonView];
    NSArray *buttonName = @[@"机酒套餐", @"特价机票", @"酒店", @"机票搜索", @"签证", @"当地游", @"门票", @"WiFi电话", @"交通票卷", @"接送包车"];
    
#warning 按钮图片改成大小为43 * 43
    for (int i = 0; i < 10; i++) {
        CGFloat X = (i % 5) * buttonView.width / 5;
        CGFloat Y = (i / 5) * buttonView.height / 2;
        DiscountButtonView *myButtonView = [[DiscountButtonView alloc] initWithFrame:CGRectMake(X, Y, buttonWidth / 5,buttonHeight / 2)];
        myButtonView.buttonImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
        myButtonView.buttonName = buttonName[i];
//        myButtonView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:1.00];
        [buttonView addSubview:myButtonView];
        
    }
    UIView *grayBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 20 + buttonHeight + 15, headerView.width, 10)];
    grayBackView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.000];
    [headerView addSubview:grayBackView];
    
    
    CGFloat a = 4;
    CGFloat imageY = grayBackView.y + grayBackView.height;
    CGFloat imageWidth = (headerView.width - a) / 2;
    CGFloat imageHeight = headerView.height - grayBackView.y - grayBackView.height;
    self.headerViewLeftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageY, imageWidth, imageHeight)];
    _headerViewLeftImage.backgroundColor = [UIColor redColor];
    [headerView addSubview:_headerViewLeftImage];
    
    self.headerViewRaghtTopImage = [[UIImageView alloc] initWithFrame:CGRectMake(imageWidth + a, imageY, imageWidth, (imageHeight - a) / 2)];
    _headerViewRaghtTopImage.backgroundColor = [UIColor yellowColor];
    [headerView addSubview:_headerViewRaghtTopImage];
    
    self.headerViewRaghtDownImage = [[UIImageView alloc] initWithFrame:CGRectMake(imageWidth + a, imageY + a + _headerViewRaghtTopImage.height, imageWidth, _headerViewRaghtTopImage.height)];
    _headerViewRaghtDownImage.backgroundColor = [UIColor greenColor];
    [headerView addSubview:_headerViewRaghtDownImage];
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 前三个cell高度
    
    
    if (_hotAreaArray.count - 1 >= indexPath.row) {
        CGFloat Height = 10 + 60 + (self.view.width - 20 * 2 - 15 * 3) + 60;
        return Height;
    } else if (_hotAreaArray.count + _discountToArray.count - 1 >= indexPath.row) {
        
        CGFloat Width = self.view.width - 20 * 2;
        CGFloat itemWidth = (self.view.width - 20 * 2 - 15 * 3) / 4;
        CGFloat Height = 10 + 60 + Width * 0.4 + itemWidth * 1.5 * 3 + 60;
        return Height;
    } else {
        CGFloat itemWidth = (self.view.width - 20 * 3) / 2;
        CGFloat Height = 10 + 60 + itemWidth * 1.2 * 3 + 20 * 2 + 15;
        return Height;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _discountToArray.count + _hotAreaArray.count + _hot_goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_hotAreaArray.count - 1 >= indexPath.row) {
        
        static NSString *const areaCell = @"areaCell";
        Hot_AreaTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:areaCell];
        if (cell == nil) {
            cell = [[Hot_AreaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:areaCell];
        }
        cell.delegate = self;
        cell.hotArea = _hotAreaArray[indexPath.row];
        return cell;
    } else if (_hotAreaArray.count + _discountToArray.count - 1 >= indexPath.row) {
        static NSString *const topicCell = @"topicCell";
        DiscountTopicTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:topicCell];
        if (cell == nil) {
            cell = [[DiscountTopicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:topicCell];
        
        }
        cell.delegate = self;
        cell.discountTopicModel = _discountToArray[indexPath.row - _hotAreaArray.count];
        return cell;
    } else {
        static NSString *const goodCell = @"goodCell";
        HotGoodTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:goodCell];
        if (cell == nil) {
            cell = [[HotGoodTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:goodCell];
        }
        cell.delegate = self;
        NSInteger index = indexPath.row - _discountToArray.count - _hotAreaArray.count;
        cell.hot_goodsArray = _hot_goodsArray[index];
        return cell;
    }

}

- (void)AZ_hotGoodTableViewCellIdNumber:(NSString *)idNumber {
    DiscountInfoViewController *discountInfoVC = [[DiscountInfoViewController alloc] init];
    discountInfoVC.idNumber = idNumber;
    [self.navigationController pushViewController:discountInfoVC animated:YES];
}

- (void)AZ_discountTopicIdNumber:(NSString *)idNumber {
    
    DiscountInfoViewController *discountInfoVC = [[DiscountInfoViewController alloc] init];
    discountInfoVC.idNumber = idNumber;
    [self.navigationController pushViewController:discountInfoVC animated:YES];

}

- (void)AZ_areaaTableViewDidIdNumber:(NSString *)idNumber {
    DiscountInfoViewController *discountInfoVC = [[DiscountInfoViewController alloc] init];
    discountInfoVC.idNumber = idNumber;
    [self.navigationController pushViewController:discountInfoVC animated:YES];
}

// 网络请求
- (void)asyncLoad {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = @"http://open.qyer.com/qyer/discount/zk/discount_index?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.88263699917143&lon=121.539418408466&page=1&track_app_channel=App%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%25209.3.4&v=1";
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
            [_hot_goodsArray removeAllObjects];
            NSMutableArray *hotgoodsArray = [NSMutableArray array];
            for (NSDictionary *hot_goodsDic in hot_goodsArray) {
                HotGoodsModel *hotGoodsModel = [[HotGoodsModel alloc] initWithDic:hot_goodsDic];
                [hotgoodsArray addObject:hotGoodsModel];
            }
            [_hot_goodsArray addObject:hotgoodsArray];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                MarkettopicModel *listImageModel = _market_topicArray[0];
                NSURL *listImageUrl = [NSURL URLWithString:listImageModel.pic];
                [_headerViewLeftImage sd_setImageWithURL:listImageUrl];
                
                MarkettopicModel *raghtTopImageModel = _market_topicArray[1];
                NSURL *raghttopImageUrl = [NSURL URLWithString:raghtTopImageModel.pic];
                [_headerViewRaghtTopImage sd_setImageWithURL:raghttopImageUrl];

                MarkettopicModel *raghtDownImageModel = _market_topicArray[2];
                NSURL *raghtDownImageUrl = [NSURL URLWithString:raghtDownImageModel.pic];
                [_headerViewRaghtDownImage sd_setImageWithURL:raghtDownImageUrl];

                
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
