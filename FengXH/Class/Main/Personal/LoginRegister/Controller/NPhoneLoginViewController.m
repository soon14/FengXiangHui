//
//  NLoginViewController.m
//  FengXH
//
//  Created by sun on 2018/10/15.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "NPhoneLoginViewController.h"
#import "NLoginTextFieldBackView.h"
#import "NPrivacyPolicyViewController.h"
#import "NRegisterViewController.h"
#import "NAccountViewController.h"
#import "NSObject+CountDown.h"
#import "UserInfoModel.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"

@interface NPhoneLoginViewController ()

/** phone */
@property(nonatomic , strong)UITextField *phoneTextField;
/** code */
@property(nonatomic , strong)UITextField *codeTextField;
/** login */
@property(nonatomic , strong)UIButton *loginButton;
/** 获取验证码 */
@property(nonatomic , strong)UIButton *getCodeButton;
/** 账号注册 */
@property(nonatomic , strong)UIButton *registerButton;
/** 密码登录 */
@property(nonatomic , strong)UIButton *passwordLoginButton;
/** 协议 */
@property(nonatomic , strong)YYLabel *agressLabel;
/** 微信登录按钮 */
@property(nonatomic , strong)UIButton *wechatButton;


@end

@implementation NPhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证登入";
    
    [self initUI];
}

#pragma mark - 微信登录请求
- (void)wechatLoginRequest:(NSString *)openid {
    NSString * urlString = @"r=apply.account.login";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                       openid,@"openid",nil];
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

#pragma mark - 验证码登录请求
- (void)codeLoginRequest {
    NSString * urlString = @"r=apply.account.login";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     self.phoneTextField.text,@"mobile",
                                     self.codeTextField.text,@"verifycode",nil];
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

#pragma mark - 获取登录验证码请求
- (void)getLoginCodeRequest {
    NSString * urlString = @"r=apply.account.verifycode2";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     self.phoneTextField.text,@"mobile",
                                     @"sms_login",@"temp",nil];
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

#pragma mark - 密码登入
- (void)passwordLoginButtonAction:(UIButton *)sender {
    NAccountViewController *VC = [[NAccountViewController alloc] init];
    MJWeakSelf
    VC.loginSuccessBlock = ^{
        if (weakSelf.loginSuccessBlock) {
            weakSelf.loginSuccessBlock();
        }
    };
    [self presentViewController:VC animated:YES completion:nil];
}

#pragma mark - 去注册
- (void)registerButtonAction:(UIButton *)sender {
    NRegisterViewController *VC = [[NRegisterViewController alloc] init];
    MJWeakSelf
    VC.loginSuccessBlock = ^{
        if (weakSelf.loginSuccessBlock) {
            weakSelf.loginSuccessBlock();
        }
    };
    [self presentViewController:VC animated:YES completion:nil];
}

#pragma mark - 登录触发方法
- (void)loginButtonAction:(UIButton *)sender {
    if ([self.codeTextField canResignFirstResponder]) {
        [self.codeTextField resignFirstResponder];
    }
    [self.view endEditing:YES];
    [DBHUD ShowInView:self.view withTitle:@"登入"];
    if ([self.phoneTextField.text length] != 11) {
        [DBHUD ShowInView:self.view withTitle:@"请输入正确的手机号"];
        return;
    }
    if ([self.codeTextField.text length] == 0) {
        [DBHUD ShowInView:self.view withTitle:@"请输入验证码"];
        return;
    }
    [self codeLoginRequest];
}

#pragma mark - 获取验证码方法
- (void)getLoginCodeAction:(UIButton *)sender {
    if ([self.phoneTextField.text length] != 11) {
        [DBHUD ShowInView:self.view withTitle:@"请输入正确的手机号"];
        return;
    }
    [self getLoginCodeRequest];
}

#pragma mark - 微信登录
- (void)wechatButtonAction:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
//            NSLog(@"uid=%@",user.uid);
//            NSLog(@"%@",user.credential);
//            NSLog(@"token=%@",user.credential.token);
//            NSLog(@"nickname=%@",user.nickname);
            [self wechatLoginRequest:user.uid];
        } else {
            [DBHUD ShowInView:self.view withTitle:@"微信授权失败，请尝试其他方式登录"];
        }
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
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeTextField.mas_bottom).offset(10);
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
    
    [self.view addSubview:self.passwordLoginButton];
    [self.passwordLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.mas_centerY);
        make.left.mas_equalTo(line.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
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
    
    [self.view addSubview:self.wechatButton];
    [self.wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_agressLabel.mas_top).offset(-30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
}

#pragma mark - lazy
- (UIButton *)wechatButton {
    if (!_wechatButton) {
        _wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechatButton setImage:[UIImage imageNamed:@"wechatLogin"] forState:UIControlStateNormal];
        [_wechatButton setTitle:@"微信登录" forState:UIControlStateNormal];
        [_wechatButton setTitleColor:KUIColorFromHex(0x8bc34a) forState:UIControlStateNormal];
        [_wechatButton.titleLabel setFont:KFont(15)];
        [_wechatButton setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 3)];
        [_wechatButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
        [_wechatButton addTarget:self action:@selector(wechatButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_wechatButton setHidden:![WXApi isWXAppInstalled]];
    }
    return _wechatButton;
}

- (YYLabel *)agressLabel {
    if (!_agressLabel) {
        _agressLabel = [[YYLabel alloc] init];
        [_agressLabel setTextColor:KUIColorFromHex(0x333333)];
        [_agressLabel setFont:KFont(10)];
    }
    return _agressLabel;
}

- (UIButton *)passwordLoginButton {
    if (!_passwordLoginButton) {
        _passwordLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passwordLoginButton setTitle:@"密码登入" forState:UIControlStateNormal];
        [_passwordLoginButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_passwordLoginButton.titleLabel setFont:KFont(12)];
        [_passwordLoginButton addTarget:self action:@selector(passwordLoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passwordLoginButton;
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

- (UIButton *)getCodeButton {
    if (!_getCodeButton) {
        _getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getCodeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_getCodeButton setTitle:@"获取动态密码" forState:UIControlStateNormal];
        [_getCodeButton.titleLabel setFont:KFont(15)];
        [_getCodeButton addTarget:self action:@selector(getLoginCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCodeButton;
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
