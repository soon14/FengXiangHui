//
//  OrderSectionFooterView.h
//  FengXH
//
//  Created by sun on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderSectionFooterView,MyOrderResultListModel;

@protocol OrderSectionFooterViewDelegate <NSObject>

#pragma mark - 支付订单按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view payButtonDidClick:(MyOrderResultListModel *)orderModel;
#pragma mark - 取消订单按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view cancelButtonDidClick:(MyOrderResultListModel *)orderModel;
#pragma mark - 删除订单按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view deleteButtonDidClick:(MyOrderResultListModel *)orderModel;
#pragma mark - 评价订单按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view evaluateButtonDidClick:(MyOrderResultListModel *)orderModel;
#pragma mark - 查看物流按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view logisticsButtonDidClick:(MyOrderResultListModel *)orderModel;
#pragma mark - 查看物流按钮
- (void)OrderSectionFooterView:(OrderSectionFooterView *)view confirmOrderButtonDidClick:(MyOrderResultListModel *)orderModel;

@end

@interface OrderSectionFooterView : UITableViewHeaderFooterView

/** 代理 */
@property(nonatomic , weak)id <OrderSectionFooterViewDelegate> delegate;
/** 订单模型 */
@property(nonatomic , strong)MyOrderResultListModel *orderModel;

@end
