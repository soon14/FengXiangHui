//
//  LoginBaseViewController.h
//  FengXH
//
//  Created by sun on 2018/10/16.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NLoginBaseViewController : UIViewController

#pragma mark - cancelAction
- (void)cancelButtonAction;

#pragma mark - 将所有 present 出来的界面 dismiss 掉
- (void)toRootViewController;

@end

NS_ASSUME_NONNULL_END
