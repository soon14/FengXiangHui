//
//  IntegralPayOrderViewController.h
//  FengXH
//
//  Created by sun on 2018/8/22.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"
@class IntegralCreatOrderResultModel,AddressResultListModel;

@interface IntegralPayOrderViewController : BaseViewController

/** 订单 Model */
@property(nonatomic , strong)IntegralCreatOrderResultModel *integralResultModel;
/** 地址 Model */
@property(nonatomic , strong)AddressResultListModel *addressModel;

@end
