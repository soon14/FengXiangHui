//
//  ConfirmOrderBottomView.h
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ConfirmPayButtonBlock)(UIButton *sender);

@interface ConfirmOrderBottomView : UIView

/** 合计价格 */
@property(nonatomic , strong)UILabel *totalPriceLabel;
/** 立即支付按钮 */
@property(nonatomic , strong)UIButton *payButton;
/** block */
@property(nonatomic , strong)ConfirmPayButtonBlock payBlock;

@end
