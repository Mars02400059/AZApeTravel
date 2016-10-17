//
//  CommunityViewController.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "CommunityViewController.h"
#import "TalkView.h"
#import "PartnerView.h"
#import "EnterView.h"
#import "CommunityWebViewViewController.h"

@interface CommunityViewController ()
<
UIScrollViewDelegate,
TalkViewDelegate,
PartnerViewDelegate
>
@property (nonatomic, strong) UIView *navigationItemView ;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *centerButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UILabel *pointLabel;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) TalkView *talkView;

@property (nonatomic, strong) PartnerView *partnerView;

@property (nonatomic, strong) EnterView *enterView;

@end

@implementation CommunityViewController

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    _navigationItemView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _navigationItemView;
    
    CGFloat buttonX = 35.f;
    CGFloat buttonWidth = (self.view.width - 50 * 2)/ 3;
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(buttonX, 0, buttonWidth, 35);
    [_leftButton setTitle:@"热议" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [_navigationItemView addSubview:_leftButton];
    
    self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _centerButton.frame = CGRectMake(buttonX + buttonWidth, 0, buttonWidth, 35);
    [_centerButton setTitle:@"进入版面" forState:UIControlStateNormal];
    [_centerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _centerButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [_centerButton addTarget:self action:@selector(centerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationItemView addSubview:_centerButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(buttonX + buttonWidth * 2, 0, buttonWidth, 35);
    [_rightButton setTitle:@"找旅伴" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationItemView addSubview:_rightButton];
    
    self.pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    _pointLabel.center = CGPointMake(_leftButton.center.x, 35);
    _pointLabel.layer.cornerRadius = 2.f;
    _pointLabel.clipsToBounds = YES;
    _pointLabel.backgroundColor = [UIColor whiteColor];
    [_navigationItemView addSubview:_pointLabel];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 44)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.contentSize = CGSizeMake(self.view.width * 3, 0);
    _scrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:_scrollView];
    
    self.talkView = [[TalkView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 48)];
    _talkView.delegate = self;
    [_scrollView addSubview:_talkView];
    
    self.enterView = [[EnterView alloc] initWithFrame:CGRectMake(_scrollView.width, 0, self.view.width, self.view.height - 64 - 48)];
    
    [_scrollView addSubview:_enterView];
    
    self.partnerView = [[PartnerView alloc] initWithFrame:CGRectMake(_scrollView.width * 2, 0, self.view.width, self.view.height - 64 - 48)];
    _partnerView.delegate = self;
    [_scrollView addSubview:_partnerView];
    
    
    
}

- (void)AZ_talkViewTableViewSpringWebViewUrl:(NSString *)webViewUrl {
    CommunityWebViewViewController *webViewVC = [[CommunityWebViewViewController alloc] init];
    webViewVC.webViewUrl = webViewUrl;
    webViewVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (void)AZ_partnerViewTableViewSpringVCWebViewUrl:(NSString *)webViewUrl {
    CommunityWebViewViewController *webViewVC = [[CommunityWebViewViewController alloc] init];
    webViewVC.webViewUrl = webViewUrl;
    webViewVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_scrollView.contentOffset.x == 0) {
        [self changeButtonInfo];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        _pointLabel.center = CGPointMake(_leftButton.center.x, 35);
    }
    if (_scrollView.contentOffset.x == self.view.width) {
        [self changeButtonInfo];
        [_centerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _centerButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        _pointLabel.center = CGPointMake(_centerButton.center.x, 35);
    }
    if (_scrollView.contentOffset.x == self.view.width * 2) {
        [self changeButtonInfo];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        _pointLabel.center = CGPointMake(_rightButton.center.x, 35);
    }
}

- (void)leftButtonAction:(UIButton *)leftButton {
    _scrollView.contentOffset = CGPointMake(0, 0);
    [self AZButton:leftButton];
}

- (void)centerButtonAction:(UIButton *)centerButton {
    _scrollView.contentOffset = CGPointMake(_scrollView.width, 0);
    [self AZButton:centerButton];
}

- (void)rightButtonAction:(UIButton *)rightButton {
    _scrollView.contentOffset = CGPointMake(_scrollView.width * 2, 0);
    [self AZButton:rightButton];
}

- (void)changeButtonInfo {
    [_leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [_centerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _centerButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
}
- (void)AZButton:(UIButton *)azButton {

    [self changeButtonInfo];
    [azButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    azButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
    _pointLabel.center = CGPointMake(azButton.center.x, 35);

    
    
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
