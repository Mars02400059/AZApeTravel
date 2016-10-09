//
//  RegisterSubsLastViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/3.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "RegisterSubsLastViewController.h"

@interface RegisterSubsLastViewController ()

@end

@implementation RegisterSubsLastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    
    CGFloat topY = 30.f;
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.frame = CGRectMake(20, topY, 30, 30);
    [returnButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnButton];
    
    UILabel *loginLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.width - 120) / 2, topY, 120, 30)];
    loginLabel.backgroundColor = [UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000];
    loginLabel.text = @"手机号注册";
    loginLabel.font = [UIFont systemFontOfSize:20.f];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:loginLabel];
    
    
    AZBaseTextField *nameTextField = [[AZBaseTextField alloc] initWithFrame:CGRectMake(20, self.view.height / 5, self.view.width - 20 * 2, 50)];
    nameTextField.placeholder = @"填写您的用户名";
    [self.view addSubview:nameTextField];
    
    
    AZBaseTextField *codeTextField = [[AZBaseTextField alloc] initWithFrame:CGRectMake(20, self.view.height / 4 + 20, self.view.width / 2 - 20, 50)];
    codeTextField.placeholder = @"填写密码 (不少于6位)";
    [self.view addSubview:codeTextField];
    
    CGFloat inviteX = 20 * 2 + codeTextField.width;
    AZBaseTextField *inviteNumberTextField = [[AZBaseTextField alloc] initWithFrame:CGRectMake(inviteX, self.view.height / 4 + 20, self.view.width - 20 - inviteX, 50)];
    inviteNumberTextField.placeholder = @"邀请码 (选填)";
    [self.view addSubview:inviteNumberTextField];
    
    
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake((self.view.width - 120) / 2, self.view.height / 4 * 3, 120, 40);
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.layer.cornerRadius = 5.f;
    [nextButton setTitle:@"完成" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    NSString *name = [NSString stringWithFormat:@"qw"];
#warning 有加密
    NSString *body = [NSString stringWithFormat:@"account_s=9260f95b9e8c4a428dffead2da3d5d13%@&account_type=1&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&grant_type=password&lat=41.20185519999997&lon=125.60576439&page=1&password=%@&track_app_channel=App%%2520Store&track_app_version=7.0.2&track_device_info=iPhone5%%2C3&track_deviceid=73524B41-B2E2-47A7-B7FD-F20ADEFBE5DA&track_os=ios%%25209.3.4&username=%@&v=1", _phoneNumber,  codeTextField.text, name];
    
}

- (void)nextButtonAction {
    
    
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (void)returnButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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
