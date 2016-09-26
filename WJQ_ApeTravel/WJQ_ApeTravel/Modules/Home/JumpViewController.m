//
//  JumpViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/9/26.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "JumpViewController.h"

@interface JumpViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation JumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(15, 0, self.view.width - 30, self.view.height - 64)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
    
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
