//
//  PartnerView.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "PartnerView.h"
#import "PartnerTableViewCell.h"

static NSInteger number = 2;

@interface PartnerView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *partnerTableView;

@property (nonatomic, strong) NSMutableArray *tableViewArray;

@end

@implementation PartnerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableViewArray = [NSMutableArray array];
        self.partnerTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _partnerTableView.dataSource = self;
        _partnerTableView.delegate = self;
        [self addSubview:_partnerTableView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _partnerTableView.frame = CGRectMake(0, 0, self.width, self.height);
    
    //默认【下拉刷新】
    self.partnerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(asyncLoadData)];
    //默认【上拉加载】
    self.partnerTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self asyncLoadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PartnerViewModel *partnerViewModel = _tableViewArray[indexPath.row];
    [self.delegate AZ_partnerViewTableViewSpringVCWebViewUrl:partnerViewModel.appview_url];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat Height = 25 + 25 + 45 + 50 + 50;
    return Height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const tableViewCell = @"cell";
    PartnerTableViewCell *cell = [_partnerTableView dequeueReusableCellWithIdentifier:tableViewCell];
    if (cell == nil) {
        cell = [[PartnerTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewCell];
    }
    PartnerViewModel *partnerViewModel = _tableViewArray[indexPath.row];
    cell.partnerViewModel = partnerViewModel;
    return cell;
}

// 网络请求
- (void)asyncLoadData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = @"http://open.qyer.com/qyer/company/search_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=41.19759848641075&lon=125.6096293717715&page=1&track_app_channel=App%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%25209.3.4&v=1";
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_tableViewArray removeAllObjects];
            
            [AZType AZTypeCacensWritePatchCachePatch:@"communityPartner.plist" cacheDic:responseObject];
            
            
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *dataDic in dataArray) {
                PartnerViewModel *partnerViewModel = [[PartnerViewModel alloc] initWithDic:dataDic];
                [_tableViewArray addObject:partnerViewModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.partnerTableView.mj_header endRefreshing];

                [_partnerTableView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            AZType *azType = [AZType new];
            NSDictionary *responseObject = [azType AZTypeGetTakeCachePatch:@"communityPartner.plist"];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                NSArray *dataArray = [responseObject objectForKey:@"data"];
                for (NSDictionary *dataDic in dataArray) {
                    PartnerViewModel *partnerViewModel = [[PartnerViewModel alloc] initWithDic:dataDic];
                    [_tableViewArray addObject:partnerViewModel];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.partnerTableView.mj_header endRefreshing];
                    
                    [_partnerTableView reloadData];
                });
                
            });
        
        }];
        
        
    });
}

- (void)loadMore {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/company/search_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=41.19759848641075&lon=125.6096293717715&page=%ld&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&v=1", number];
        number++;
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *dataDic in dataArray) {
                PartnerViewModel *partnerViewModel = [[PartnerViewModel alloc] initWithDic:dataDic];
                [_tableViewArray addObject:partnerViewModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                [self.partnerTableView.mj_footer endRefreshing];
                [_partnerTableView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
        
    });


}


@end
