//
//  OrderAfterSaleViewController.h
//  FengXH
//
//  Created by sun on 2018/8/15.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderAfterSaleViewController : BaseViewController

@property(nonatomic,strong)NSString *orderId;//订单id

-(instancetype)initWithType:(NSInteger)type;//0申请售后 1售后详情


@end
