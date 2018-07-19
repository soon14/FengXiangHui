//
//  LoginViewController.m
//  FengXH
//
//  Created by sun on 2018/7/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginRegisterLabel.h"
#import "LoginRegisterTextField.h"
#import "ForgetPasswordViewController.h"
#import "LoginRegisterButton.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

/** 电话号码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *phoneTextField;
/** 密码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *passwordTextField;
/** 忘记密码按钮 */
@property(nonatomic , strong)UIButton *forgetPasswordButton;
/** 登录按钮 */
@property(nonatomic , strong)LoginRegisterButton *loginButton;
/** 注册按钮 */
@property(nonatomic , strong)UIButton *registerButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipDownAction:)];
    [swipDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipDown];
    
    
    [self initUI];
}

#pragma mark - 收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 向下滑动
- (void)swipDownAction:(UISwipeGestureRecognizer *)sender {
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionDown: {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
            break;
            
        default:
            break;
    }
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
    
    //密码
    LoginRegisterLabel *label_2 = [[LoginRegisterLabel alloc] init];
    [label_2 setText:@"请输入密码"];
    [self.view addSubview:label_2];
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_1.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(label_2.mas_bottom).offset(12);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line_2 = [[UIView alloc] init];
    [line_2 setBackgroundColor:KLineColor];
    [self.view addSubview:line_2];
    [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passwordTextField.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(295);
        make.height.mas_equalTo(1);
    }];
    
    //忘记密码
    [self.view addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_passwordTextField.mas_bottom);
        make.right.mas_equalTo(line_2.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    //登录按钮
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_2.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(295);
        make.height.mas_equalTo(40);
    }];
    
    //还没账号
    LoginRegisterLabel *label_3 = [[LoginRegisterLabel alloc] init];
    [label_3 setText:@"还没有账号？"];
    [self.view addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginButton.mas_bottom).offset(20);
        make.right.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_3.mas_right);
        make.centerY.mas_equalTo(label_3.mas_centerY);
    }];
    
}

#pragma mark - 登录
- (void)loginButtonAction:(UIButton *)sender {
    NSLog(@"登录");
}

#pragma mark - 弹出找回密码界面
- (void)forgetPasswordAction:(UIButton *)sender {
    ForgetPasswordViewController *forgetPasswordVC = [ForgetPasswordViewController alloc];
    [self presentViewController:forgetPasswordVC animated:YES completion:^{
        
    }];
}

#pragma mark - 弹出注册界面
- (void)registerButtonAction:(UIButton *)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:^{
        
    }];
}

#pragma mark - lazy
- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitleColor:KUIColorFromHex(0xf1a540) forState:UIControlStateNormal];
        [_registerButton.titleLabel setFont:KFont(16)];
        [_registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (LoginRegisterButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [LoginRegisterButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
        [_loginButton.layer setMasksToBounds:YES];
        [_loginButton.layer setCornerRadius:20];
    }
    return _loginButton;
}

- (UIButton *)forgetPasswordButton {
    if (!_forgetPasswordButton) {
        _forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordButton setTitleColor:KUIColorFromHex(0x999999) forState:UIControlStateNormal];
        [_forgetPasswordButton.titleLabel setFont:KFont(16)];
        [_forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasswordButton addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPasswordButton;
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

- (LoginRegisterTextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[LoginRegisterTextField alloc] init];
        [_phoneTextField setPlaceholder:@"请输入手机号码"];
        [_phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return _phoneTextField;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
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