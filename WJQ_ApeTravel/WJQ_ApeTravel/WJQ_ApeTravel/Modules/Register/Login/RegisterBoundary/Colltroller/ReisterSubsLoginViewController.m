//
//  ReisterSubsLoginViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/3.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "ReisterSubsLoginViewController.h"
#import "RegisterSubsProvingViewController.h"


@interface ReisterSubsLoginViewController ()

@property (nonatomic, strong) AZBaseTextField *loginTextFielf;

@end

@implementation ReisterSubsLoginViewController

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
    
    self.loginTextFielf = [[AZBaseTextField alloc] initWithFrame:CGRectMake(20 + 60, self.view.height / 5, self.view.width - 20 - 60 - 20, 40)];
    _loginTextFielf.keyboardType = UIKeyboardTypeNumberPad;
    _loginTextFielf.placeholder = @"填写您的手机号码";
    [self.view addSubview:_loginTextFielf];
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake((self.view.width - 120) / 2, self.view.height / 3 * 2, 120, 40);
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.layer.cornerRadius = 5.f;
    [nextButton setTitle:@"下 一 步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor colorWithRed:0.29 green:0.75 blue:0.47 alpha:1.000] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

- (void)nextButtonAction {
    if (_loginTextFielf.text.length < 12 && _loginTextFielf.text.length > 10) {
        RegisterSubsProvingViewController *provingVC = [[RegisterSubsProvingViewController alloc] init];
        provingVC.titleLabelText = _loginTextFielf.text;
        [self presentViewController:provingVC animated:YES completion:nil];
    } else {
        NSLog(@"电话号格式不正确");
    }
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
