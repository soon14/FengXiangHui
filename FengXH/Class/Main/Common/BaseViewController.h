//
//  BaseViewController.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BaseViewControllerLoginSuccess)();
typedef void (^BaseViewControllerLoginFailure)();

@interface BaseViewController : UIViewController

#pragma mark - 弹出登录界面
- (void)presentLoginViewControllerWithSuccessBlock:(BaseViewControllerLoginSuccess)success
                                  WithFailureBlock:(BaseViewControllerLoginFailure)failure;
#pragma mark - 收回界面
- (void)dismissCurrenViewController;

@end
