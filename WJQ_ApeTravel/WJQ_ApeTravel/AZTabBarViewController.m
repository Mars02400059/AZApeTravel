//
//  AZTabBarViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/15.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "AZTabBarViewController.h"
#import "HomeViewController.h"
#import "FootprintViewController.h"
#import "DiscountViewController.h"
#import "CommunityViewController.h"
#import "RegisterViewController.h"

@interface AZTabBarViewController ()

@end

@implementation AZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置启动页面时间
    
    
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    
    [self setViewController:homeVc tabBarTitle:@"推荐" imageName:@"推荐" selectedImageName:@"推荐 (1)"];
    
    FootprintViewController *footprintVC = [[FootprintViewController alloc] init];
    [self setViewController:footprintVC tabBarTitle:@"目的地" imageName:@"目的地" selectedImageName:@"目的地 (1)"];
    
    DiscountViewController *discountVC = [[DiscountViewController alloc] init];
    [self setViewController:discountVC tabBarTitle:@"旅行商城" imageName:@"商城" selectedImageName:@"商城 (1)"];
    
    CommunityViewController *communityVC = [[CommunityViewController alloc] init];
    [self setViewController:communityVC tabBarTitle:@"社区" imageName:@"社区" selectedImageName:@"社区 (1)"];
    
#if 0
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self setViewController:registerVC tabBarTitle:@"我的" imageName:@"我" selectedImageName:@"我 (1)"];
#endif
}

/// 设置视图, 并添加到容量视图控制器
- (void)setViewController:(UIViewController *)viewController tabBarTitle:(NSString *)tabBarTitle imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:tabBarTitle image:image selectedImage:selectedImage];
    [self addChildViewController:navigationController];
    
    
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
