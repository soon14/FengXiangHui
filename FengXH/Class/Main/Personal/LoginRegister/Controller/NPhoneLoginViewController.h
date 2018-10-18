//
//  NLoginViewController.h
//  FengXH
//
//  Created by sun on 2018/10/15.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "NLoginBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^NLoginViewControllerSuccessBlock)();

@interface NPhoneLoginViewController : NLoginBaseViewController

/** 登录成功 block */
@property(nonatomic , strong)NLoginViewControllerSuccessBlock loginSuccessBlock;

@end

NS_ASSUME_NONNULL_END
