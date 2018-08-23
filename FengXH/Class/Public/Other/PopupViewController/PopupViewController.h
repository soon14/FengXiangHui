//
//  PopupViewController.h
//  PopupView_demo
//
//  Created by sun on 2017/2/14.
//  Copyright © 2017年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupViewController : UIViewController

@property(nonatomic , strong)UIButton * backCancelButton;//布满全屏幕的取消按钮，也是灰色背景

@property(nonatomic , strong)UIView *  popupView;//弹出的 View

//收回
- (void)takeBackView;

//弹出
- (void)showView;

@end
