//
//  TalkView.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "TalkView.h"
#import "TalkViewTableViewCell.h"
#import "TalkViewImageTableViewCell.h"
#import "TalkViewTwoImageTableViewCell.h"
#import "TalkViewThreeImageTableViewCell.h"

static NSInteger number = 2;

@interface TalkView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *talkTableView;

@property (nonatomic, strong) NSMutableArray *tableViewArray;

@end

@implementation TalkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableViewArray = [NSMutableArray array];
        self.talkTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _talkTableView.delegate = self;
        _talkTableView.dataSource = self;
        [self addSubview:_talkTableView];
        //默认【下拉刷新】
        self.talkTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(asyncLoadData)];
        //默认【上拉加载】
        self.talkTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        [self asyncLoadData];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _talkTableView.frame = CGRectMake(0, 0, self.width, self.height);
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TalkViewModel *talkViewModel = _tableViewArray[indexPath.row];
    [self.delegate AZ_talkViewTableViewSpringWebViewUrl:talkViewModel.appview_url];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TalkViewModel *talkViewModel = _tableViewArray[indexPath.row];
    
    if (talkViewModel.bigpic_arr.count == 0) {
        CGFloat Height = 25 + 35 + 55 + 50 + 10;
        return Height;
    } else {
        CGFloat Height = 25 + 35 + 55 + 50 + 10 + (self.width - (10 + 46 + 10) - 20 - 20 * 2) / 3;
        return Height;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TalkViewModel *talkViewModel = _tableViewArray[indexPath.row];
    
    if (talkViewModel.bigpic_arr.count == 0) {
        static NSString *const talkViewCell = @"talkViewCell";
        TalkViewTableViewCell *cell = [_talkTableView dequeueReusableCellWithIdentifier:talkViewCell];
        if (cell == nil) {
            cell = [[TalkViewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:talkViewCell];
        }
        cell.talkViewModel = talkViewModel;
        return cell;
    } else if (talkViewModel.bigpic_arr.count == 1){
        static NSString *const talkViewImageCell = @"talkViewImageCell";
        TalkViewImageTableViewCell *cell = [_talkTableView dequeueReusableCellWithIdentifier:talkViewImageCell];
        if (cell == nil) {
            cell = [[TalkViewImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:talkViewImageCell];
        }
        cell.talkViewModel = talkViewModel;
        return cell;
    } else if (talkViewModel.bigpic_arr.count == 2) {
        static NSString *const talkViewTwoImageCell = @"talkViewTwoImageCell";
        TalkViewTwoImageTableViewCell *cell = [_talkTableView dequeueReusableCellWithIdentifier:talkViewTwoImageCell];
        if (cell == nil) {
            cell = [[TalkViewTwoImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:talkViewTwoImageCell];
        }
        cell.talkViewModel = talkViewModel;
        return cell;
    } else {
        static NSString *const talkViewThreeImageCell = @"talkViewThreeImageCell";
        TalkViewThreeImageTableViewCell *cell = [_talkTableView dequeueReusableCellWithIdentifier:talkViewThreeImageCell];
        if (cell == nil) {
            cell = [[TalkViewThreeImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:talkViewThreeImageCell];
        }
        cell.talkViewModel = talkViewModel;
        return cell;
    }
    
    
}

// 网络请求
- (void)asyncLoadData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = @"http://open.qyer.com/qyer/community/hotbbs/index?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&lat=41.19759848641075&lon=125.6096293717715&page=1&track_app_channel=App%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%25209.3.4&v=1";
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_tableViewArray removeAllObjects];
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *dataDic in dataArray) {
                TalkViewModel *talkViewModel = [[TalkViewModel alloc] initWithDic:dataDic];
                [_tableViewArray addObject:talkViewModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_talkTableView.mj_header endRefreshing];
                [_talkTableView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
        
    });
}

- (void)loadMore {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/community/hotbbs/index?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&lat=41.19759848641075&lon=125.6096293717715&page=%ld&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&v=1", number];
        NSLog(@"%ld", number);
        number++;
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *dataDic in dataArray) {
                TalkViewModel *talkViewModel = [[TalkViewModel alloc] initWithDic:dataDic];
                [_tableViewArray addObject:talkViewModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_talkTableView.mj_footer endRefreshing];
                [_talkTableView reloadData];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error : %@", error);
        }];
        
        
    });
}


@end
