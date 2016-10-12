//
//  RegisterViewController.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTableViewCell.h"
#import "RegisterButton.h"


@interface RegisterViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *backView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
//    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    self.navigationController.navigationBar.hidden = NO;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Action)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.dataArray = @[@[@"我的订单", @"我收藏的折扣", @"我的优惠券"], @[@"我收藏的目的地", @"我的足迹", @"等我点评的目的地"], @[@"我发布的帖子", @"我的问答", @"我的结伴"]];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.height = self.view.height - 64 - 50;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width * 0.75)];
    headerImageView.userInteractionEnabled = YES;
    headerImageView.image = [UIImage imageNamed:@"登录背景"];
    headerImageView.backgroundColor =  [UIColor colorWithRed:0.809 green:1.000 blue:0.197 alpha:1.000];
    _tableView.tableHeaderView = headerImageView;
    
    
    RegisterButton *registerButton = [[RegisterButton alloc] initWithFrame:CGRectMake(0, headerImageView.height / 3, headerImageView.size.width, 100)];
    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [headerImageView addSubview:registerButton];
    
    
    CGFloat backViewHeight = self.view.width / 4;
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, headerImageView.height - backViewHeight, self.view.width, backViewHeight)];
    [headerImageView addSubview:_backView];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    //  毛玻璃视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = _backView.bounds;
    effectView.alpha = 0.9;
    //添加到要有毛玻璃特效的控件中
    [_backView addSubview:effectView];

    
    
    CGFloat centerX = _backView.width / 6;
    CGFloat frame = 40.f;
    CGFloat buttonCenterY = _backView.height / 3;
    CGFloat labelWidth = _backView.width / 3;
    CGFloat labelCenterY = _backView.height / 3 * 2 + 10;
    
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.backgroundColor = [UIColor redColor];
    collectButton.frame = CGRectMake(0, 0, frame, frame);
    collectButton.center = CGPointMake(centerX, buttonCenterY);
    [_backView addSubview:collectButton];
    
    UILabel *collectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 20)];
    collectLabel.center = CGPointMake(centerX, labelCenterY);
    collectLabel.text = @"收藏的帖子";
    collectLabel.textAlignment = NSTextAlignmentCenter;
    collectLabel.font = [UIFont systemFontOfSize:15.f];
    collectLabel.textColor = [UIColor whiteColor];
    [_backView addSubview:collectLabel];
    
    UIButton *highlightsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    highlightsButton.backgroundColor = [UIColor redColor];
    highlightsButton.frame = CGRectMake(0, 0, frame, frame);
    highlightsButton.center = CGPointMake(centerX * 3, buttonCenterY);
    [_backView addSubview:highlightsButton];
    UILabel *highlightsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 20)];
    highlightsLabel.center = CGPointMake(centerX * 3, labelCenterY);
    highlightsLabel.text = @"我的集锦";
    highlightsLabel.textAlignment = NSTextAlignmentCenter;
    highlightsLabel.font = [UIFont systemFontOfSize:15.f];
    highlightsLabel.textColor = [UIColor whiteColor];
    [_backView addSubview:highlightsLabel];
    
    UIButton *tirpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tirpButton.backgroundColor = [UIColor redColor];
    tirpButton.frame = CGRectMake(0, 0, frame, frame);
    tirpButton.center = CGPointMake(centerX * 5, buttonCenterY);
    [_backView addSubview:tirpButton];
    UILabel *tirpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 20)];
    tirpLabel.center = CGPointMake(centerX * 5, labelCenterY);
    tirpLabel.text = @"我的行程";
    tirpLabel.textAlignment = NSTextAlignmentCenter;
    tirpLabel.font = [UIFont systemFontOfSize:15.f];
    tirpLabel.textColor = [UIColor whiteColor];
    [_backView addSubview:tirpLabel];
    
}

- (void)Action {

}

- (void)registerButtonAction {
    RegisterSubsViewController *registerSubsVC = [[RegisterSubsViewController alloc] init];
    [self presentViewController:registerSubsVC animated:YES completion:nil];
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (_tableView.contentOffset.y > 0) {
//        self.navigationController.navigationBar.subviews.firstObject.alpha = _tableView.contentOffset.y / 50;
//        
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60 * 3 + 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegisterTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[RegisterTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.tableViewArray = _dataArray[indexPath.row];
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
