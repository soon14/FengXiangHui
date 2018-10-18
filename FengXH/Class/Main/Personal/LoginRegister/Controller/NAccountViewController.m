//
//  NAccountViewController.m
//  FengXH
//
//  Created by sun on 2018/10/16.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "NAccountViewController.h"
#import "NLoginTextFieldBackView.h"
#import "NRegisterViewController.h"
#import "NPrivacyPolicyViewController.h"
#import "NForgetPasswordViewController.h"
#import "UserInfoModel.h"

@interface NAccountViewController ()<UITextFieldDelegate>

/** phone */
@property(nonatomic , strong)UITextField *phoneTextField;
/** code */
@property(nonatomic , strong)UITextField *passwordTextField;
/** login */
@property(nonatomic , strong)UIButton *loginButton;
/** 获取验证码 */
@property(nonatomic , strong)UIButton *forgetPasswordButton;
/** 账号注册 */
@property(nonatomic , strong)UIButton *registerButton;
/** 密码登录 */
@property(nonatomic , strong)UIButton *codeLoginButton;
/** 协议 */
@property(nonatomic , strong)YYLabel *agressLabel;

@end

@implementation NAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码登入";
    
    [self initUI];
}



#pragma mark - 忘记密码
- (void)forgetPasswordButtonAction:(UIButton *)sender {
    NForgetPasswordViewController *VC = [[NForgetPasswordViewController alloc] init];
    [self presentViewController:VC animated:YES completion:nil];
}

#pragma mark - 验证码登入
- (void)codeLoginButtonAction:(UIButton *)sender {
    [self cancelButtonAction];
}

#pragma mark - 去注册
- (void)registerButtonAction:(UIButton *)sender {
    NRegisterViewController *VC = [[NRegisterViewController alloc] init];
    MJWeakSelf
    VC.loginSuccessBlock = ^{
        weakSelf.loginSuccessBlock();
    };
    [self presentViewController:VC animated:YES completion:nil];
}

#pragma mark - 登录触发方法
- (void)loginButtonAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self.phoneTextField.text length] != 11) {
        [DBHUD ShowInView:self.view withTitle:@"请输入正确的手机号"];
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
    [self loginRequest];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loginButtonAction:nil];
    return YES;
}

#pragma mark - 登录请求
- (void)loginRequest {
    NSString * urlString = @"r=apply.account.login";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     self.phoneTextField.text,@"mobile",
                                     self.passwordTextField.text,@"pwd",nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
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
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 约束控件
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
    
    [codeBackView addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.right.mas_offset(-10);
        make.width.mas_equalTo(75);
    }];
    
    [codeBackView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_equalTo(_forgetPasswordButton.mas_left).offset(-10);
        make.top.bottom.mas_offset(0);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeBackView.mas_bottom).offset(10);
        make.left.mas_offset(40);
        make.right.mas_offset(-40);
        make.height.mas_equalTo(42);
    }];
    
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:KRedColor];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginButton.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(2);
    }];
    
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.mas_centerY);
        make.right.mas_equalTo(line.mas_left).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];
    
    [self.view addSubview:self.codeLoginButton];
    [self.codeLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.mas_centerY);
        make.left.mas_equalTo(line.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    
    [self.view addSubview:self.agressLabel];
    [self.agressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-(20+KBottomHeight));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"登录即代表您已经同意《疯享汇隐私政策》"];
    MJWeakSelf
    [text yy_setTextHighlightRange:NSMakeRange(10, 9) color:KRedColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NPrivacyPolicyViewController *VC = [[NPrivacyPolicyViewController alloc] init];
        [weakSelf presentViewController:VC animated:YES completion:nil];
    }];
    self.agressLabel.attributedText = text;  //设置富文本
    
}

#pragma mark - lazy
- (YYLabel *)agressLabel {
    if (!_agressLabel) {
        _agressLabel = [[YYLabel alloc] init];
        [_agressLabel setTextColor:KUIColorFromHex(0x333333)];
        [_agressLabel setFont:KFont(10)];
    }
    return _agressLabel;
}

- (UIButton *)codeLoginButton {
    if (!_codeLoginButton) {
        _codeLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeLoginButton setTitle:@"验证码登入" forState:UIControlStateNormal];
        [_codeLoginButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_codeLoginButton.titleLabel setFont:KFont(12)];
        [_codeLoginButton addTarget:self action:@selector(codeLoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeLoginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"账号注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_registerButton.titleLabel setFont:KFont(12)];
        [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)forgetPasswordButton {
    if (!_forgetPasswordButton) {
        _forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasswordButton.titleLabel setFont:KFont(15)];
        [_forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPasswordButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundColor:KRedColor];
        [_loginButton setTitle:@"登入" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:KFont(15)];
        [_loginButton.layer setMasksToBounds:YES];
        [_loginButton.layer setCornerRadius:21];
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        [_passwordTextField setFont:KFont(15)];
        [_passwordTextField setSecureTextEntry:YES];
        [_passwordTextField setTintColor:KRedColor];
        [_passwordTextField setPlaceholder:@"密码登入"];
        [_passwordTextField setTextColor:KUIColorFromHex(0x333333)];
        [_passwordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
        [_passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_passwordTextField setDelegate:self];
        [_passwordTextField setReturnKeyType:UIReturnKeyGo];
    }
    return _passwordTextField;
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
