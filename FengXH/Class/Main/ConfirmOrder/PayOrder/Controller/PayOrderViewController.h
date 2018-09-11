//
//  PayOrderViewController.h
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@interface PayOrderViewController : BaseViewController

/** 订单号 */
@property(nonatomic , copy)NSString *orderID;
/** 参团 id */
@property(nonatomic , copy)NSString *teamID;
/** 订单编号*/
@property(nonatomic , copy)NSString *orderNum;
/** 金额*/
@property(nonatomic , copy)NSString *price;

@end
