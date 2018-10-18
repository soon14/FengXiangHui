//
//  LoginBaseViewController.m
//  FengXH
//
//  Created by sun on 2018/10/16.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "NLoginBaseViewController.h"

@interface NLoginBaseViewController ()

/** title */
@property(nonatomic , strong)UILabel *titleLabel;
/** cancel */
@property(nonatomic , strong)UIButton *cancelButton;
/** logo */
@property(nonatomic , strong)UIImageView *logoImageView;

@end

@implementation NLoginBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(KDevice_Is_iPhoneX?44:20);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_equalTo(_titleLabel.mas_centerY);
        make.width.height.mas_equalTo(44);
    }];
    
    [self.view addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(100);
    }];
}

- (void)setTitle:(NSString *)title {
    [self.titleLabel setText:title];
}

#pragma mark - 将所有 present 出来的界面 dismiss 掉
- (void)toRootViewController {
    UIViewController *viewController = self;
    while (viewController.presentingViewController) {
        //判断是否为最底层控制器
        if ([viewController isKindOfClass:[NLoginBaseViewController class]]) {
            viewController = viewController.presentingViewController;
        } else {
            break;
        }
    }
    if (viewController) {
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - cancelAction
- (void)cancelButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy
- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        [_logoImageView setImage:[UIImage imageNamed:@"login_icon"]];
    }
    return _logoImageView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setImage:[UIImage imageNamed:@"loginCancel"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
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
