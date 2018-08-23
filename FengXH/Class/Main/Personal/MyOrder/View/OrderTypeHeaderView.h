//
//  OrderTypeHeaderView.h
//  FengXH
//
//  Created by HubinSun on 2017/10/10.
//  Copyright © 2017年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OrderTypeButtonBlock)(NSInteger index);

@interface OrderTypeHeaderView : UIView

@property(nonatomic , strong)UIButton *allButton;
@property(nonatomic , strong)UIButton *waitPaidButton;
@property(nonatomic , strong)UIButton *waitSendButton;
@property(nonatomic , strong)UIButton *waitReceiveButton;
@property(nonatomic , strong)UIButton *waitEvaluateButton;
@property(nonatomic , strong)UIView *moveLine;

@property(nonatomic , strong)OrderTypeButtonBlock orderTypeBlock;

@end
