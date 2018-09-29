//
//  LoginViewController.h
//  FengXH
//
//  Created by sun on 2018/7/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^LoginViewControllerSuccessBlock)();

@interface LoginViewController : BaseViewController

/** 登录成功 block */
@property(nonatomic , strong)LoginViewControllerSuccessBlock loginSuccessBlock;

@end
