//
//  AZBaseController.m
//  WJQ_ApeTravelApp
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZBaseController.h"

@interface AZBaseController ()

@property(nonatomic, strong)UIActivityIndicatorView*activity;

@property (nonatomic, strong) MBProgressHUD *hud;


@end

@implementation AZBaseController

#if 1



#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.label.text = @"加载中..";
    _hud.animationType = MBProgressHUDAnimationZoomIn;

#if 1
    
    
    
#endif
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
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
