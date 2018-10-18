//
//  NAccountViewController.h
//  FengXH
//
//  Created by sun on 2018/10/16.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "NLoginBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^NAccountViewControllerLoginSuccessBlock)();

@interface NAccountViewController : NLoginBaseViewController

/** 登录成功 block */
@property(nonatomic , strong)NAccountViewControllerLoginSuccessBlock loginSuccessBlock;

@end

NS_ASSUME_NONNULL_END
