//
//  PaySuccessViewController.h
//  FengXH
//
//  Created by sun on 2018/8/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@interface PaySuccessViewController : BaseViewController

/** 支付方式 */
@property(nonatomic , copy)NSString *payType;
/** 订单号 */
@property(nonatomic , copy)NSString *orderID;
/** 组团订单号 */
@property(nonatomic , copy)NSString *teamID;

@end
