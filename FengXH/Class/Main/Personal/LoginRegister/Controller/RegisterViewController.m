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

@interface RegisterViewController ()

/** 手机号输入框 */
@property(nonatomic , strong)LoginRegisterTextField *phoneTextField;
/** 图形验证码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *imageCodeTextField;
/** 图形验证码图片 */
@property(nonatomic , strong)UIImageView *imageCodeImageView;
/** 短信验证码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *smsCodeTextField;
/** 登录密码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *passwordTextField;
/** 重复登录密码输入框 */
@property(nonatomic , strong)LoginRegisterTextField *confirmPasswordTextField;
/** 立即注册按钮 */
@property(nonatomic , strong)LoginRegisterButton *registerButton;

@end

@implementation RegisterViewController

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
    
    
}



#pragma mark - lazy

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
