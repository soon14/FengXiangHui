//
//  OrderNumberTypeHeaderView.h
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyOrderResultListModel;

@interface OrderNumberTypeHeaderView : UITableViewHeaderFooterView

/** 订单模型 */
@property(nonatomic , strong)MyOrderResultListModel *orderModel;

@end
