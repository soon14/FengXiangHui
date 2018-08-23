//
//  PayOrderOrderInfoCell.h
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayOrderResultModel;

@interface PayOrderOrderInfoCell : UITableViewCell

/** 订单信息 Model */
@property(nonatomic , strong)PayOrderResultModel *orderResultModel;

@end
