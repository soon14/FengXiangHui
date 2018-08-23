//
//  OrderDetailsViewController.h
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^OrderDetailRequestSuccessBlock)();

@interface OrderDetailsViewController : BaseViewController

/** 订单号 */
@property(nonatomic , copy)NSString *orderID;

/** block */
@property(nonatomic , strong)OrderDetailRequestSuccessBlock requestSuccessBlock;

@end
