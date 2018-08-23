//
//  OrderDetailBottomView.h
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderDetailBottomView,OrderDetailResultModel;

@protocol OrderDetailBottomViewDelegate <NSObject>

#pragma mark - 支付订单按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view payButtonDidClick:(OrderDetailResultModel *)orderModel;
#pragma mark - 取消订单按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view cancelButtonDidClick:(OrderDetailResultModel *)orderModel;
#pragma mark - 删除订单按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view deleteButtonDidClick:(OrderDetailResultModel *)orderModel;
#pragma mark - 评价订单按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view evaluateButtonDidClick:(OrderDetailResultModel *)orderModel;
#pragma mark - 申请退款按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view refundButtonDidClick:(OrderDetailResultModel *)orderModel;
#pragma mark - 确认收货按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view confirmOrderButtonDidClick:(OrderDetailResultModel *)orderModel;
#pragma mark - 申请售后按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view afterSaleButtonDidClick:(OrderDetailResultModel *)orderModel;
#pragma mark - 取消申请按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view cancelRefundButtonDidClick:(OrderDetailResultModel *)orderModel;
#pragma mark - 查看申请售后进度按钮
- (void)OrderDetailBottomView:(OrderDetailBottomView *)view checkAfterSaleButtonDidClick:(OrderDetailResultModel *)orderModel;

@end

@interface OrderDetailBottomView : UIView

/** 代理 */
@property(nonatomic , weak)id <OrderDetailBottomViewDelegate> delegate;
/** OrderDetailResultModel */
@property(nonatomic , strong)OrderDetailResultModel *orderModel;

@end
