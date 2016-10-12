//
//  RegisterSubsViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/1.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "RegisterSubsViewController.h"

@interface RegisterSubsViewController ()

@end

@implementation RegisterSubsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    
    
    CGFloat topY = 30.f;
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.frame = CGRectMake(20, topY, 30, 30);
    [returnButton setImage:[UIImage imageNamed:@"错号"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnButtonAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:returnButton];
    
    UILabel *loginLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.width - 70) / 2, topY, 70, 30)];
    loginLabel.backgroundColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    loginLabel.text = @"登录";
    loginLabel.font = [UIFont systemFontOfSize:20.f];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:loginLabel];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(self.view.width - 20 - 75, topY, 75, 30);
    loginButton.backgroundColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
    loginButton.layer.cornerRadius = 5.f;
    loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    loginButton.layer.borderWidth = 1.f;
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    CGFloat X = self.view.height / 5;
    AZBaseTextField *nameTextField = [[AZBaseTextField alloc] initWithFrame:CGRectMake(20, X, self.view.width - 20 * 2, 40)];
    nameTextField.placeholder = @"输入邮箱/用户名";
    [self.view addSubview:nameTextField];
    
    AZBaseTextField *codeTextField = [[AZBaseTextField alloc] initWithFrame:CGRectMake(20, X + nameTextField.height, self.view.width - 20 * 2, 40)];
    codeTextField.placeholder = @"输入密码";
    [self.view addSubview:codeTextField];
    
    CGFloat forgetCodeButtonY = X + nameTextField.height + codeTextField.height + 20;
    AZUnderlineButton *forgetCodeButton = [AZUnderlineButton buttonWithType:UIButtonTypeCustom];
    forgetCodeButton.frame = CGRectMake((self.view.width - 65) / 2, forgetCodeButtonY, 65, 17);
    [forgetCodeButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetCodeButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [forgetCodeButton setTitleColor:[UIColor colorWithWhite:0.764 alpha:1.000] forState:UIControlStateNormal];
    [self.view addSubview:forgetCodeButton];
    
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterButton.frame = CGRectMake((self.view.width - 150) / 2, self.view.height / 2 - 20, 150, 40);
    enterButton.center = self.view.center;
    enterButton.backgroundColor = [UIColor whiteColor];
    [enterButton setTitle:@"登录" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000] forState:UIControlStateNormal];
    enterButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:enterButton];
    
    UIButton *phoneNumberenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneNumberenterButton.frame = enterButton.frame;
    phoneNumberenterButton.center = CGPointMake(enterButton.centerX, enterButton.centerY + enterButton.height + 10);
    phoneNumberenterButton.backgroundColor = [UIColor  colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    phoneNumberenterButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [phoneNumberenterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneNumberenterButton setTitle:@"手机号登录" forState:UIControlStateNormal];
    [self.view addSubview:phoneNumberenterButton];
    
    
    
}

- (void)returnButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginButtonAction {
    ReisterSubsLoginViewController *loginVC = [[ReisterSubsLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
//    [self.navigationController pushViewController:loginVC animated:YES];
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
