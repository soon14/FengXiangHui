//
//  ForgetPasswordViewController.m
//  FengXH
//
//  Created by sun on 2018/7/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "LoginRegisterLabel.h"
#import "LoginRegisterTextField.h"
#import "LoginRegisterButton.h"

@interface ForgetPasswordViewController ()

/** 手机号输入框 */
@property(nonatomic , strong)LoginRegisterTextField *phoneTextField;
/** 图形验证码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *imageCodeTextField;
/** 图形验证码图片 */
@property(nonatomic , strong)UIImageView *imageCodeImageView;
/** 短信验证码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *smsCodeTextField;
/** 获取短信验证码按钮 */
@property(nonatomic , strong)UIButton *getSmsCodeButton;
/** 登录密码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *passwordTextField;
/** 重复登录密码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *confirmPasswordTextField;
/** 立即找回按钮 */
@property(nonatomic , strong)LoginRegisterButton *retrieveButton;
/** 立即登录按钮 */
@property(nonatomic , strong)UIButton *loginButton;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
}

#pragma mark - 绘制界面
- (void)initUI {
    //背景
    UIImageView *backImageView = [[UIImageView alloc] init];
    [backImageView setImage:[UIImage imageNamed:@"registerBackImage"]];
    [backImageView setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(95*KScreenRatio);
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
    
    //图形验证码
    LoginRegisterLabel *label_2 = [[LoginRegisterLabel alloc] init];
    [label_2 setText:@"图形验证码"];
    [self.view addSubview:label_2];
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_1.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.imageCodeTextField];
    [self.imageCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_2.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line_2 = [[UIView alloc] init];
    [line_2 setBackgroundColor:KLineColor];
    [self.view addSubview:line_2];
    [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageCodeTextField.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(295);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.imageCodeImageView];
    [self.imageCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_imageCodeTextField.mas_bottom);
        make.right.mas_equalTo(line_2.mas_right);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(31);
    }];
    
    //短信验证码
    LoginRegisterLabel *label_3 = [[LoginRegisterLabel alloc] init];
    [label_3 setText:@"短信验证码"];
    [self.view addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_2.mas_bottom).offset(12);
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
    [self.view addSubview:self.retrieveButton];
    [self.retrieveButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.mas_equalTo(_retrieveButton.mas_bottom).offset(20);
        make.right.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_6.mas_right);
        make.centerY.mas_equalTo(label_6.mas_centerY);
    }];
}

#pragma mark - 登录
- (void)loginButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 弹出找回密码界面
- (void)getSmsCodeAction:(UIButton *)sender {
    NSLog(@"获取验证码");
}

#pragma mark - 弹出注册界面
- (void)retrieveButtonAction:(UIButton *)sender {
    NSLog(@"立即找回");
}

#pragma mark - lazy
- (UIButton *)getSmsCodeButton {
    if (!_getSmsCodeButton) {
        _getSmsCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getSmsCodeButton setTitleColor:KUIColorFromHex(0x999999) forState:UIControlStateNormal];
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

- (LoginRegisterButton *)retrieveButton {
    if (!_retrieveButton) {
        _retrieveButton = [LoginRegisterButton buttonWithType:UIButtonTypeCustom];
        [_retrieveButton setTitle:@"立即找回" forState:UIControlStateNormal];
        [_retrieveButton.layer setMasksToBounds:YES];
        [_retrieveButton.layer setCornerRadius:20];
        [_retrieveButton addTarget:self action:@selector(retrieveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retrieveButton;
}

- (LoginRegisterTextField *)confirmPasswordTextField {
    if (!_confirmPasswordTextField) {
        _confirmPasswordTextField = [[LoginRegisterTextField alloc] init];
        [_confirmPasswordTextField setPlaceholder:@"请重复密码"];
        [_confirmPasswordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    }
    return _confirmPasswordTextField;
}

- (LoginRegisterTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[LoginRegisterTextField alloc] init];
        [_passwordTextField setPlaceholder:@"请输入密码"];
        [_passwordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
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

- (UIImageView *)imageCodeImageView {
    if (!_imageCodeImageView) {
        _imageCodeImageView = [[UIImageView alloc] init];
        [_imageCodeImageView setBackgroundColor:KTableBackgroundColor];
    }
    return _imageCodeImageView;
}

- (LoginRegisterTextField *)imageCodeTextField {
    if (!_imageCodeTextField) {
        _imageCodeTextField = [[LoginRegisterTextField alloc] init];
        [_imageCodeTextField setPlaceholder:@"请输入图形验证码"];
        [_imageCodeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return _imageCodeTextField;
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
