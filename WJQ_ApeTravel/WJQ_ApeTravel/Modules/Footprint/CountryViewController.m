//
//  CountryViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/26.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "CountryViewController.h"



@interface CountryViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

// 整个页面
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CountryViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 40) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const tableViewCell = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:tableViewCell];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewCell];
    }
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
