//
//  RegisterSubsProvingViewController.m
//  WJQ_ApeTravel
//
//  Created by mars on 16/10/3.
//  Copyright © 2016年 Mars02400059. All rights reserved.
//

#import "RegisterSubsProvingViewController.h"
#import "RegisterSubsLastViewController.h"


@interface RegisterSubsProvingViewController ()

@property (nonatomic, strong) AZBaseTextField *provingTextFielf;

@end

@implementation RegisterSubsProvingViewController

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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.width - 250) / 2, self.view.height / 4, 250, 25)];
    titleLabel.text = [NSString stringWithFormat:@"验证短信已发送至%@", _titleLabelText];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithWhite:0.215 alpha:1.000];
    titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self.view addSubview:titleLabel];
    
    self.provingTextFielf = [[AZBaseTextField alloc] initWithFrame:CGRectMake(50, self.view.height / 3, 150, 50)];
    _provingTextFielf.placeholder = @"       输入验证码";
    [self.view addSubview:_provingTextFielf];
    
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
     if (_provingTextFielf.text.length < 5 && _provingTextFielf.text.length > 3) {
         RegisterSubsLastViewController *lastVC = [[RegisterSubsLastViewController alloc] init];
         lastVC.phoneNumber = _titleLabelText;
         lastVC.provingText = _provingTextFielf.text;
         [self presentViewController:lastVC animated:YES completion:nil];
     } else {
         NSLog(@"验证码格式输入错误");
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
