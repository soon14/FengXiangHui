//
//  ChangePasswordViewController.m
//  FengXH
//
//  Created by  on 2018/7/31.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "NSObject+CountDown.h"

@interface ChangePasswordViewController ()

/** 短信验证码输入框 */
@property(nonatomic , strong)UITextField *smsCodeTextField;
/** 获取短信验证码按钮 */
@property(nonatomic , strong)UIButton *getSmsCodeButton;
/** 登录密码输入框 */
@property(nonatomic , strong)UITextField *passwordTextField;
/** 重复登录密码输入框 */
@property(nonatomic , strong)UITextField *confirmPasswordTextField;
/** 确认按钮 */
@property(nonatomic , strong)UIButton *confirmButton;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"修改密码";
    
    [self initUI];
}

#pragma mark - UI
- (void)initUI {
    CGFloat leftControlWidth = 100;
    CGFloat controlHeight = 40;
    
    UILabel *label_1 = [[UILabel alloc] init];
    [label_1 setText:@"手机号"];
    [label_1 setFont:KFont(15)];
    [label_1 setTextColor:KUIColorFromHex(0x333333)];
    [self.view addSubview:label_1];
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(leftControlWidth);
        make.height.mas_equalTo(controlHeight);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    [phoneLabel setText:[[NSUserDefaults standardUserDefaults] objectForKey:KUserMobile]];
    [phoneLabel setFont:KFont(15)];
    [phoneLabel setTextColor:KUIColorFromHex(0x333333)];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_equalTo(label_1.mas_right).offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(controlHeight);
    }];
    
    UILabel *label_2 = [[UILabel alloc] init];
    [label_2 setText:@"短信验证码"];
    [label_2 setFont:KFont(15)];
    [label_2 setTextColor:KUIColorFromHex(0x333333)];
    [self.view addSubview:label_2];
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top. mas_equalTo(label_1.mas_bottom).offset(0);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(leftControlWidth);
        make.height.mas_equalTo(controlHeight);
    }];
    
    [self.view addSubview:self.getSmsCodeButton];
    [self.getSmsCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_1.mas_bottom);
        make.right.mas_offset(-5);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(controlHeight);
    }];
    
    [self.view addSubview:self.smsCodeTextField];
    [self.smsCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_1.mas_bottom);
        make.left.mas_equalTo(label_1.mas_right).offset(10);
        make.right.mas_equalTo(_getSmsCodeButton.mas_left).offset(-10);
        make.height.mas_equalTo(controlHeight);
    }];
    
    
    UILabel *label_3 = [[UILabel alloc] init];
    [label_3 setText:@"新密码"];
    [label_3 setFont:KFont(15)];
    [label_3 setTextColor:KUIColorFromHex(0x333333)];
    [self.view addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top. mas_equalTo(label_2.mas_bottom).offset(0);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(leftControlWidth);
        make.height.mas_equalTo(controlHeight);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_2.mas_bottom);
        make.left.mas_equalTo(label_1.mas_right).offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(controlHeight);
    }];
    
    UILabel *label_4 = [[UILabel alloc] init];
    [label_4 setText:@"确认密码"];
    [label_4 setFont:KFont(15)];
    [label_4 setTextColor:KUIColorFromHex(0x333333)];
    [self.view addSubview:label_4];
    [label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top. mas_equalTo(label_3.mas_bottom).offset(0);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(leftControlWidth);
        make.height.mas_equalTo(controlHeight);
    }];
    
    [self.view addSubview:self.confirmPasswordTextField];
    [self.confirmPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_3.mas_bottom);
        make.left.mas_equalTo(label_1.mas_right).offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(controlHeight);
    }];
    
    [self.view addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_confirmPasswordTextField.mas_bottom).offset(40);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_equalTo(controlHeight);
    }];
    
    
}

#pragma mark - 立即修改按钮被点击
- (void)confirmButtonAction:(UIButton *)sender {
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
    
    [self changePasswordRequest];
}


#pragma mark - 修改密码请求
- (void)changePasswordRequest {
    NSString *url = @"r=apply.account.forget";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
            [[NSUserDefaults standardUserDefaults] objectForKey:KUserMobile],@"mobile",
                                                  self.smsCodeTextField.text,@"verifycode",
                                                 self.passwordTextField.text,@"pwd",nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
            [self performSelector:@selector(pop) withObject:nil afterDelay:0.8f];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 返回上个界面
- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取短信验证码
- (void)getSmsCodeRequest {
    NSString *url = @"r=apply.account.verifycode2";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserMobile],@"mobile",
                                                                                 @"sms_forget",@"temp",nil];
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

#pragma mark - lazy
- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"立即修改" forState:UIControlStateNormal];
        [_confirmButton setBackgroundColor:KRedColor];
        [_confirmButton.titleLabel setFont:KFont(15)];
        [_confirmButton.layer setMasksToBounds:YES];
        [_confirmButton.layer setCornerRadius:5];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UITextField *)confirmPasswordTextField {
    if (!_confirmPasswordTextField) {
        _confirmPasswordTextField = [[UITextField alloc] init];
        [_confirmPasswordTextField setTextColor:KUIColorFromHex(0x333333)];
        [_confirmPasswordTextField setFont:KFont(15)];
        [_confirmPasswordTextField setPlaceholder:@"请再次确认密码"];
    }
    return _confirmPasswordTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        [_passwordTextField setTextColor:KUIColorFromHex(0x333333)];
        [_passwordTextField setFont:KFont(15)];
        [_passwordTextField setPlaceholder:@"请输入新密码"];
    }
    return _passwordTextField;
}

- (UIButton *)getSmsCodeButton {
    if (!_getSmsCodeButton) {
        _getSmsCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getSmsCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getSmsCodeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_getSmsCodeButton.titleLabel setFont:KFont(15)];
        [_getSmsCodeButton addTarget:self action:@selector(getSmsCodeRequest) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getSmsCodeButton;
}

- (UITextField *)smsCodeTextField {
    if (!_smsCodeTextField) {
        _smsCodeTextField = [[UITextField alloc] init];
        [_smsCodeTextField setTextColor:KUIColorFromHex(0x333333)];
        [_smsCodeTextField setFont:KFont(15)];
        [_smsCodeTextField setPlaceholder:@"5位验证码"];
        [_smsCodeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return _smsCodeTextField;
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
