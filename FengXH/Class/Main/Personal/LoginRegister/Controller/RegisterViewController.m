//
//  RegisterViewController.m
//  FengXH
//
//  Created by sun on 2018/7/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginRegisterLabel.h"
#import "LoginRegisterTextField.h"
#import "LoginRegisterButton.h"
#import "NSObject+CountDown.h"

@interface RegisterViewController ()

/** 手机号输入框 */
@property(nonatomic , strong)LoginRegisterTextField *phoneTextField;
/** 短信验证码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *smsCodeTextField;
/** 获取短信验证码按钮 */
@property(nonatomic , strong)UIButton *getSmsCodeButton;
/** 登录密码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *passwordTextField;
/** 重复登录密码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *confirmPasswordTextField;
/** 立即注册按钮 */
@property(nonatomic , strong)LoginRegisterButton *registerButton;
/** 立即登录按钮 */
@property(nonatomic , strong)UIButton *loginButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
}

#pragma mark - 获取验证码
- (void)getSmsCodeAction:(UIButton *)sender {
    if ([self.phoneTextField.text length] != 11) {
        [DBHUD ShowInView:self.view withTitle:@"请输入正确的手机号"];
        return;
    }

    [self getSmsCodeRequest];
}

#pragma mark - 立即注册按钮被点击
- (void)registerButtonAction:(UIButton *)sender {
    if ([self.phoneTextField.text length] != 11) {
        [DBHUD ShowInView:self.view withTitle:@"请输入正确的手机号"];
        return;
    }
    if ([self.smsCodeTextField.text length] == 0) {
        [DBHUD ShowInView:self.view withTitle:@"请输入短信验证码"];
        return;
    }
    if ([self.passwordTextField.text length] == 0) {
        [DBHUD ShowInView:self.view withTitle:@"请输入密码"];
        return;
    }
    if ([self.passwordTextField.text length] < 6) {
        [DBHUD ShowInView:self.view withTitle:@"密码至少6位"];
        return;
    }
    if ([self.passwordTextField.text length] > 16) {
        [DBHUD ShowInView:self.view withTitle:@"密码至多16位"];
        return;
    }
    if (![self.confirmPasswordTextField.text isEqualToString:self.passwordTextField.text]) {
        [DBHUD ShowInView:self.view withTitle:@"两次密码输入不一致"];
        return;
    }
    
    [self registerRequest];
}


#pragma mark - 登录
- (void)loginButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - 注册请求
- (void)registerRequest {
    NSString * urlString = @"r=apply.account.register";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     self.phoneTextField.text,@"mobile",
                                     self.smsCodeTextField.text,@"verifycode",
                                     self.passwordTextField.text,@"pwd",nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
            [self performSelector:@selector(loginButtonAction:) withObject:nil afterDelay:0.8f];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 获取短信验证码请求
- (void)getSmsCodeRequest {
    NSString * urlString = @"r=apply.account.verifycode2";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     self.phoneTextField.text,@"mobile",
                                     @"sms_reg",@"temp",nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
            [self.getSmsCodeButton countDownTime:60 countDownBlock:^(NSUInteger timer) {
                [self.getSmsCodeButton setTitleColor:KUIColorFromHex(0x999999) forState:UIControlStateNormal];
                [self.getSmsCodeButton setTitle:[NSString stringWithFormat:@"%zd (s)后重发", (long)timer] forState:UIControlStateNormal];
                self.getSmsCodeButton.enabled = NO;
            } outTimeBlock:^{
                [self.getSmsCodeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
                [self.getSmsCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                self.getSmsCodeButton.enabled = YES;
            }];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 绘制界面
- (void)initUI {
    //背景
    UIImageView *backImageView = [[UIImageView alloc] init];
    [backImageView setImage:[UIImage imageNamed:@"loginBackImage"]];
    [backImageView setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(140*KScreenRatio);
    }];
    
    //logo
    UIImageView *logoImageView = [[UIImageView alloc] init];
    [logoImageView setImage:[UIImage imageNamed:@"loginLogo"]];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(backImageView.mas_bottom);
        make.width.height.mas_equalTo(100);
    }];
    
    //手机号
    LoginRegisterLabel *label_1 = [[LoginRegisterLabel alloc] init];
    [label_1 setText:@"11位手机号"];
    [self.view addSubview:label_1];
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(28);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(label_1.mas_bottom).offset(12);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line_1 = [[UIView alloc] init];
    [line_1 setBackgroundColor:KLineColor];
    [self.view addSubview:line_1];
    [line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneTextField.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(295);
        make.height.mas_equalTo(1);
    }];
    
    //短信验证码
    LoginRegisterLabel *label_3 = [[LoginRegisterLabel alloc] init];
    [label_3 setText:@"短信验证码"];
    [self.view addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_1.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.smsCodeTextField];
    [self.smsCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_3.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line_3 = [[UIView alloc] init];
    [line_3 setBackgroundColor:KLineColor];
    [self.view addSubview:line_3];
    [line_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_smsCodeTextField.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(295);
        make.height.mas_equalTo(1);
    }];
    
    //获取短信验证码
    [self.view addSubview:self.getSmsCodeButton];
    [self.getSmsCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_smsCodeTextField.mas_bottom);
        make.right.mas_equalTo(line_3.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    //登录密码
    LoginRegisterLabel *label_4 = [[LoginRegisterLabel alloc] init];
    [label_4 setText:@"登录密码"];
    [self.view addSubview:label_4];
    [label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_3.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_4.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line_4 = [[UIView alloc] init];
    [line_4 setBackgroundColor:KLineColor];
    [self.view addSubview:line_4];
    [line_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passwordTextField.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(295);
        make.height.mas_equalTo(1);
    }];
    
    //重复登录密码
    LoginRegisterLabel *label_5 = [[LoginRegisterLabel alloc] init];
    [label_5 setText:@"重复登录密码"];
    [self.view addSubview:label_5];
    [label_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_4.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.confirmPasswordTextField];
    [self.confirmPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_5.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line_5 = [[UIView alloc] init];
    [line_5 setBackgroundColor:KLineColor];
    [self.view addSubview:line_5];
    [line_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_confirmPasswordTextField.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(295);
        make.height.mas_equalTo(1);
    }];
    
    //立即注册按钮
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_5.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(295);
        make.height.mas_equalTo(40);
    }];
    
    //已有账号
    LoginRegisterLabel *label_6 = [[LoginRegisterLabel alloc] init];
    [label_6 setText:@"已有账号？"];
    [self.view addSubview:label_6];
    [label_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_registerButton.mas_bottom).offset(20);
        make.right.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_6.mas_right);
        make.centerY.mas_equalTo(label_6.mas_centerY);
    }];
}

#pragma mark - lazy
- (UIButton *)getSmsCodeButton {
    if (!_getSmsCodeButton) {
        _getSmsCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getSmsCodeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_getSmsCodeButton.titleLabel setFont:KFont(16)];
        [_getSmsCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getSmsCodeButton addTarget:self action:@selector(getSmsCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getSmsCodeButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitleColor:KUIColorFromHex(0xf1a540) forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:KFont(16)];
        [_loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (LoginRegisterButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [LoginRegisterButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerButton.layer setMasksToBounds:YES];
        [_registerButton.layer setCornerRadius:20];
        [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (LoginRegisterTextField *)confirmPasswordTextField {
    if (!_confirmPasswordTextField) {
        _confirmPasswordTextField = [[LoginRegisterTextField alloc] init];
        [_confirmPasswordTextField setPlaceholder:@"请重复密码"];
        [_confirmPasswordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
        [_confirmPasswordTextField setSecureTextEntry:YES];
    }
    return _confirmPasswordTextField;
}

- (LoginRegisterTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[LoginRegisterTextField alloc] init];
        [_passwordTextField setPlaceholder:@"请输入密码"];
        [_passwordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
        [_passwordTextField setSecureTextEntry:YES];
    }
    return _passwordTextField;
}

- (LoginRegisterTextField *)smsCodeTextField {
    if (!_smsCodeTextField) {
        _smsCodeTextField = [[LoginRegisterTextField alloc] init];
        [_smsCodeTextField setPlaceholder:@"请输入验证码"];
        [_smsCodeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return _smsCodeTextField;
}

- (LoginRegisterTextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[LoginRegisterTextField alloc] init];
        [_phoneTextField setPlaceholder:@"请输入手机号码"];
        [_phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return _phoneTextField;
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
