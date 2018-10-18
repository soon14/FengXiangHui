//
//  NRegisterViewController.m
//  FengXH
//
//  Created by sun on 2018/10/16.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "NRegisterViewController.h"
#import "NLoginTextFieldBackView.h"
#import "NPrivacyPolicyAlertView.h"
#import "NPrivacyPolicyViewController.h"
#import "NSObject+CountDown.h"
#import "UserInfoModel.h"

@interface NRegisterViewController ()<UITextFieldDelegate>

/** 手机号码 */
@property(nonatomic , strong)UITextField *phoneTextField;
/** 获取验证码 */
@property(nonatomic , strong)UIButton *getCodeButton;
/** 验证码 */
@property(nonatomic , strong)UITextField *codeTextField;
/** 密码 */
@property(nonatomic , strong)UITextField *passwordTextField;
/** 密码是否可见 */
@property(nonatomic , strong)UIButton *passwordSecureButton;
/** 确认密码 */
@property(nonatomic , strong)UITextField *confirmTextField;
/** 确认密码是否可见 */
@property(nonatomic , strong)UIButton *confirmSecureButton;
/** 立即注册按钮 */
@property(nonatomic , strong)UIButton *registerButton;
/** 隐私条款弹窗 */
@property(nonatomic , strong)NPrivacyPolicyAlertView *alertView;

@end

@implementation NRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机快速注册";
    
    [self initUI];
    
    [self.view addSubview:self.alertView];
}

#pragma mark - 同意、不同意以及查看隐私条款按钮触发方法
- (void)agreeButtonAction:(NSInteger)index {
    switch (index) {
        case 0: {
            if (self.alertView) {
                [self.alertView removeFromSuperview];
            }
        } break;
        case 1: {
            [self dismissViewControllerAnimated:YES completion:nil];
        } break;
        case 3: {
            NPrivacyPolicyViewController *VC = [[NPrivacyPolicyViewController alloc] init];
            [self presentViewController:VC animated:YES completion:nil];
        } break;
        default:
            break;
    }
}

#pragma mark - 登入密码是否看见
- (void)passwordSecureButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.passwordTextField setSecureTextEntry:!sender.selected];
}

#pragma mark - 确认密码是否可见
- (void)confirmSecureButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.confirmTextField setSecureTextEntry:!sender.selected];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.passwordTextField) {
        if ([self.passwordTextField canResignFirstResponder]) {
            [self.passwordTextField resignFirstResponder];
            [self.confirmTextField becomeFirstResponder];
        }
    } else if (textField == self.confirmTextField) {
        if ([self.confirmTextField canResignFirstResponder]) {
            [self.confirmTextField resignFirstResponder];
            [self registerButtonAction:nil];
        }
    }
    return YES;
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
    [self.view endEditing:YES];
    if ([self.phoneTextField.text length] != 11) {
        [DBHUD ShowInView:self.view withTitle:@"请输入正确的手机号"];
        return;
    }
    if ([self.codeTextField.text length] == 0) {
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
    if (![self.confirmTextField.text isEqualToString:self.passwordTextField.text]) {
        [DBHUD ShowInView:self.view withTitle:@"两次密码输入不一致"];
        return;
    }
    
    [self registerRequest];
}


#pragma mark - 注册请求
- (void)registerRequest {
    NSString * urlString = @"r=apply.account.register";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     self.phoneTextField.text,@"mobile",
                                     self.codeTextField.text,@"verifycode",
                                     self.passwordTextField.text,@"pwd",nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
            [self performSelector:@selector(loginRequest) withObject:nil afterDelay:0.4f];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 登录请求
- (void)loginRequest {
    NSString * urlString = @"r=apply.account.login";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     self.phoneTextField.text,@"mobile",
                                     self.passwordTextField.text,@"pwd",nil];
    [DBHUD ShowProgressInview:self.view Withtitle:@"正在帮您自动登录..."];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            UserInfoModel *infoModel = [UserInfoModel yy_modelWithDictionary:responseDic[@"result"]];
            [ShareManager saveUserInfo:infoModel];
            
            [DBHUD ShowInView:self.view withTitle:@"登录成功"];

            if (self.loginSuccessBlock) {
                self.loginSuccessBlock();
            }
            
            [self performSelector:@selector(toRootViewController) withObject:nil afterDelay:0.8f];
        } else {
            [DBHUD ShowInView:self.view withTitle:@"登录失败，请至账号登入页面进行登入!"];
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
            [self.getCodeButton countDownTime:60 countDownBlock:^(NSUInteger timer) {
                [self.getCodeButton setTitleColor:KUIColorFromHex(0x999999) forState:UIControlStateNormal];
                [self.getCodeButton setTitle:[NSString stringWithFormat:@"%zd (s)后重发", (long)timer] forState:UIControlStateNormal];
                self.getCodeButton.enabled = NO;
                if ([self.phoneTextField canResignFirstResponder]) {
                    [self.phoneTextField resignFirstResponder];
                    if ([self.codeTextField canBecomeFirstResponder]) {
                        [self.codeTextField becomeFirstResponder];
                    }
                }
            } outTimeBlock:^{
                [self.getCodeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
                [self.getCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                self.getCodeButton.enabled = YES;
            }];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - UI
- (void)initUI {
    NLoginTextFieldBackView *phoneBackView = [[NLoginTextFieldBackView alloc] init];
    [self.view addSubview:phoneBackView];
    [phoneBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(KNaviHeight + 180);
        make.left.mas_offset(40);
        make.right.mas_offset(-40);
        make.height.mas_equalTo(42);
    }];
    
    [phoneBackView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-10);
        make.top.bottom.mas_offset(0);
    }];
    
    NLoginTextFieldBackView *codeBackView = [[NLoginTextFieldBackView alloc] init];
    [self.view addSubview:codeBackView];
    [codeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneBackView.mas_bottom).offset(10);
        make.left.mas_equalTo(phoneBackView.mas_left);
        make.right.mas_equalTo(phoneBackView.mas_right);
        make.height.mas_equalTo(42);
    }];
    
    [codeBackView addSubview:self.getCodeButton];
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.right.mas_offset(-15);
        make.width.mas_equalTo(100);
    }];
    
    [codeBackView addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_equalTo(_getCodeButton.mas_left).offset(-10);
        make.top.bottom.mas_offset(0);
    }];
    
    NLoginTextFieldBackView *passwordBackView = [[NLoginTextFieldBackView alloc] init];
    [self.view addSubview:passwordBackView];
    [passwordBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeBackView.mas_bottom).offset(10);
        make.left.mas_equalTo(phoneBackView.mas_left);
        make.right.mas_equalTo(phoneBackView.mas_right);
        make.height.mas_equalTo(42);
    }];
    
    [passwordBackView addSubview:self.passwordSecureButton];
    [self.passwordSecureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(passwordBackView.mas_right);
        make.top.bottom.mas_offset(0);
        make.width.mas_equalTo(passwordBackView.mas_height);
    }];
    
    [passwordBackView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_equalTo(_passwordSecureButton.mas_left).offset(-10);
        make.top.bottom.mas_offset(0);
    }];
    
    
    NLoginTextFieldBackView *confirmBackView = [[NLoginTextFieldBackView alloc] init];
    [self.view addSubview:confirmBackView];
    [confirmBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordBackView.mas_bottom).offset(10);
        make.left.mas_equalTo(phoneBackView.mas_left);
        make.right.mas_equalTo(phoneBackView.mas_right);
        make.height.mas_equalTo(42);
    }];
    
    [confirmBackView addSubview:self.confirmSecureButton];
    [self.confirmSecureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(confirmBackView.mas_right);
        make.top.bottom.mas_offset(0);
        make.width.mas_equalTo(confirmBackView.mas_height);
    }];
    
    [confirmBackView addSubview:self.confirmTextField];
    [self.confirmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_equalTo(_confirmSecureButton.mas_left).offset(-10);
        make.top.bottom.mas_offset(0);
    }];
    
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(confirmBackView.mas_bottom).offset(10);
        make.left.mas_equalTo(phoneBackView.mas_left);
        make.right.mas_equalTo(phoneBackView.mas_right);
        make.height.mas_equalTo(42);
    }];
    
}

#pragma mark - lazy
- (NPrivacyPolicyAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[NPrivacyPolicyAlertView alloc] initWithFrame:self.view.bounds];
        MJWeakSelf
        _alertView.agreePolicyBlock = ^(NSInteger index) {
            [weakSelf agreeButtonAction:index];
        };
    }
    return _alertView;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setBackgroundColor:KRedColor];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton.titleLabel setFont:KFont(15)];
        [_registerButton.layer setMasksToBounds:YES];
        [_registerButton.layer setCornerRadius:21];
        [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)confirmSecureButton {
    if (!_confirmSecureButton) {
        _confirmSecureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmSecureButton setImage:[UIImage imageNamed:@"secure"] forState:UIControlStateNormal];
        [_confirmSecureButton setImage:[UIImage imageNamed:@"noSecure"] forState:UIControlStateSelected];
        [_confirmSecureButton addTarget:self action:@selector(confirmSecureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmSecureButton;
}

- (UITextField *)confirmTextField {
    if (!_confirmTextField) {
        _confirmTextField = [[UITextField alloc] init];
        [_confirmTextField setFont:KFont(15)];
        [_confirmTextField setSecureTextEntry:YES];
        [_confirmTextField setTintColor:KRedColor];
        [_confirmTextField setPlaceholder:@"确认密码"];
        [_confirmTextField setTextColor:KUIColorFromHex(0x333333)];
        [_confirmTextField setKeyboardType:UIKeyboardTypeASCIICapable];
        [_confirmTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_confirmTextField setDelegate:self];
        [_confirmTextField setReturnKeyType:UIReturnKeyGo];
    }
    return _confirmTextField;
}

- (UIButton *)passwordSecureButton {
    if (!_passwordSecureButton) {
        _passwordSecureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passwordSecureButton setImage:[UIImage imageNamed:@"secure"] forState:UIControlStateNormal];
        [_passwordSecureButton setImage:[UIImage imageNamed:@"noSecure"] forState:UIControlStateSelected];
        [_passwordSecureButton addTarget:self action:@selector(passwordSecureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passwordSecureButton;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        [_passwordTextField setFont:KFont(15)];
        [_passwordTextField setSecureTextEntry:YES];
        [_passwordTextField setTintColor:KRedColor];
        [_passwordTextField setPlaceholder:@"登入密码"];
        [_passwordTextField setTextColor:KUIColorFromHex(0x333333)];
        [_passwordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
        [_passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_passwordTextField setDelegate:self];
        [_passwordTextField setReturnKeyType:UIReturnKeyNext];
    }
    return _passwordTextField;
}

- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] init];
        [_codeTextField setFont:KFont(15)];
        [_codeTextField setTintColor:KRedColor];
        [_codeTextField setPlaceholder:@"动态密码"];
        [_codeTextField setTextColor:KUIColorFromHex(0x333333)];
        [_codeTextField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return _codeTextField;
}

- (UIButton *)getCodeButton {
    if (!_getCodeButton) {
        _getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getCodeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_getCodeButton setTitle:@"获取动态密码" forState:UIControlStateNormal];
        [_getCodeButton.titleLabel setFont:KFont(15)];
        [_getCodeButton addTarget:self action:@selector(getSmsCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeButton;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        [_phoneTextField setFont:KFont(15)];
        [_phoneTextField setTintColor:KRedColor];
        [_phoneTextField setPlaceholder:@"手机号码"];
        [_phoneTextField setTextColor:KUIColorFromHex(0x333333)];
        [_phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [_phoneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
    return _phoneTextField;
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
