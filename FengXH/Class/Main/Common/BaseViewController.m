//
//  BaseViewController.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"
#import "NPhoneLoginViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KTableBackgroundColor;
    
}

#pragma mark - 弹出登录界面
- (void)presentLoginViewControllerWithSuccessBlock:(BaseViewControllerLoginSuccess)success WithFailureBlock:(BaseViewControllerLoginFailure)failure {
    NPhoneLoginViewController *loginVC = [[NPhoneLoginViewController alloc] init];
    loginVC.loginSuccessBlock = ^{
        success();
    };
    [self presentViewController:loginVC animated:YES completion:nil];
}


#pragma mark - 收回界面
- (void)dismissCurrenViewController {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
