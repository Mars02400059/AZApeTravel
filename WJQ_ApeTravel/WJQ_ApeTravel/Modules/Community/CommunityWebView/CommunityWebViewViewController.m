//
//  CommunityWebViewViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/5.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "CommunityWebViewViewController.h"

@interface CommunityWebViewViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation CommunityWebViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webViewUrl]];
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
}

//- (void)leftBarButtonItemAction {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
