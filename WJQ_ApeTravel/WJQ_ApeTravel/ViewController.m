//
//  ViewController.m
//  WJQ_ApeTravel
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "ViewController.h"
#import "AZTabBarViewController.h"
#import "HomeViewController.h"

#define WIDTH (NSInteger)self.view.bounds.size.width
#define HEIGHT (NSInteger)self.view.bounds.size.height




@interface ViewController ()

<
UIScrollViewDelegate
>
{
    // 创建页码控制器
    UIPageControl *myPageControl;
    // 判断是否是第一次进入应用
    BOOL flag;
    UIScrollView *myScrollView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    for (int i = 0; i < 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"0%d.jpg", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT)];
        // 在最后一页设置按钮
        if (2 == i) {
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width / 2 - 100, self.view.height / 5, 200, 40)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
//            titleLabel.textColor = [UIColor ]
            
            
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(WIDTH / 3, HEIGHT * 7 / 8, WIDTH / 7, HEIGHT / 16);
            button.frame = CGRectMake(self.view.width / 2 - 50, self.view.height - 130, 100, 35);
            [button setTitle:@"点击进入" forState:UIControlStateNormal];
            button.layer.borderWidth = 1.f;
            button.layer.cornerRadius = button.height / 4;
            button.clipsToBounds = YES;
            button.titleLabel.font = [UIFont systemFontOfSize:15.f];
//            [UILabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:0.720 green:0.750 blue:0.705 alpha:0.250];
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(WIDTH * 3, HEIGHT);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH / 3, HEIGHT * 15 / 16, WIDTH / 3, HEIGHT / 16)];
    myPageControl.numberOfPages = 3;
    [myPageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
//    pageControl.pageIndicatorTintColor = [UIColor cyanColor];
//    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.799 green:0.860 blue:0.350 alpha:1.000];
    [self.view addSubview:myPageControl];


}

- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    [myScrollView setContentOffset:CGPointMake((pageControl.currentPage) * self.view.bounds.size.width, 0) animated:YES];
}
// 死循环假象, 以及连接page
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:myScrollView]) {
        NSInteger pageNumber = scrollView.contentOffset.x / scrollView.bounds.size.width; // 求第几张图片
        myPageControl.currentPage = pageNumber; // 设置当前所在页, 使滑动与page关联
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width * pageNumber, 0);
        
    }
}


- (void)buttonAction {
    flag = YES;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    // 保存用户数据
    [userDef setBool:flag forKey:@"notFirst"];
    [userDef synchronize];
    // 切换到根视图控制器
    self.view.window.rootViewController = [[AZTabBarViewController alloc] init];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
