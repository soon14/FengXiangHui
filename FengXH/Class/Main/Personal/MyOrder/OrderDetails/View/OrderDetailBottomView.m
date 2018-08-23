//
//  OrderDetailBottomView.m
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderDetailBottomView.h"
#import "OrderDetailResultModel.h"

@interface OrderDetailBottomView ()

/** 删除订单 */
@property(nonatomic , strong)UIButton *deleteButton;
/** 支付订单 */
@property(nonatomic , strong)UIButton *payButton;
/** 申请退款 */
@property(nonatomic , strong)UIButton *refundButton;
/** 确认收货 */
@property(nonatomic , strong)UIButton *confirmButton;
/** 取消订单 */
@property(nonatomic , strong)UIButton *cancelButton;
/** 申请售后 */
@property(nonatomic , strong)UIButton *afterSaleButton;
/** 评价 */
@property(nonatomic , strong)UIButton *evaluateButton;
/** 取消退款申请 */
@property(nonatomic , strong)UIButton *cancelRefundButton;
/** 查看申请售后进度 */
@property(nonatomic , strong)UIButton *checkAfterSaleButton;

@end

@implementation OrderDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        [self addSubview:self.payButton];
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        [self addSubview:self.refundButton];
        [self.refundButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        [self addSubview:self.confirmButton];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        
        [self addSubview:self.cancelButton];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_deleteButton.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        [self addSubview:self.afterSaleButton];
        [self.afterSaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_deleteButton.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        [self addSubview:self.evaluateButton];
        [self.evaluateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_cancelButton.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(60);
        }];
        
        [self addSubview:self.cancelRefundButton];
        [self.cancelRefundButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        [self addSubview:self.checkAfterSaleButton];
        [self.checkAfterSaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_cancelRefundButton.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setOrderModel:(OrderDetailResultModel *)orderModel {
    _orderModel = orderModel;
    if ([_orderModel.refundstate isEqualToString:@"(申请售后中)"]) {
        [self.cancelRefundButton setHidden:YES];
        [self.checkAfterSaleButton setHidden:NO];
        [self.deleteButton setHidden:NO];
        [self.payButton setHidden:YES];
        [self.refundButton setHidden:YES];
        [self.confirmButton setHidden:YES];
        [self.cancelButton setHidden:YES];
        [self.afterSaleButton setHidden:YES];
        [self.evaluateButton setHidden:NO];
    } else if ([_orderModel.refundstate isEqualToString:@"(申请退款中)"]) {
        [self.cancelRefundButton setHidden:NO];
        [self.checkAfterSaleButton setHidden:NO];
        [self.deleteButton setHidden:YES];
        [self.payButton setHidden:YES];
        [self.refundButton setHidden:YES];
        [self.confirmButton setHidden:YES];
        [self.cancelButton setHidden:YES];
        [self.afterSaleButton setHidden:YES];
        [self.evaluateButton setHidden:YES];
    } else {
        [self.cancelRefundButton setHidden:YES];
        [self.checkAfterSaleButton setHidden:YES];
        if ([_orderModel.status1 integerValue] == 0) {
            //待付款
            [self.deleteButton setHidden:YES];
            [self.payButton setHidden:NO];
            [self.refundButton setHidden:YES];
            [self.confirmButton setHidden:YES];
            [self.cancelButton setHidden:NO];
            [self.afterSaleButton setHidden:YES];
            [self.evaluateButton setHidden:YES];
        } else if ([_orderModel.status1 integerValue] == 1) {
            //待发货
            [self.deleteButton setHidden:YES];
            [self.payButton setHidden:YES];
            [self.refundButton setHidden:NO];
            [self.confirmButton setHidden:YES];
            [self.cancelButton setHidden:YES];
            [self.afterSaleButton setHidden:YES];
            [self.evaluateButton setHidden:YES];
        } else if ([_orderModel.status1 integerValue] == 2) {
            //待收货
            [self.deleteButton setHidden:YES];
            [self.payButton setHidden:YES];
            [self.refundButton setHidden:YES];
            [self.confirmButton setHidden:NO];
            [self.cancelButton setHidden:YES];
            [self.afterSaleButton setHidden:YES];
            [self.evaluateButton setHidden:YES];
        } else if ([_orderModel.status1 integerValue] == 3) {
            //已完成
            [self.deleteButton setHidden:NO];
            [self.payButton setHidden:YES];
            [self.refundButton setHidden:YES];
            [self.confirmButton setHidden:YES];
            [self.cancelButton setHidden:YES];
            [self.afterSaleButton setHidden:NO];
            [self.evaluateButton setHidden:NO];
        } else {
            //已取消
            [self.deleteButton setHidden:NO];
            [self.payButton setHidden:YES];
            [self.refundButton setHidden:YES];
            [self.confirmButton setHidden:YES];
            [self.cancelButton setHidden:YES];
            [self.afterSaleButton setHidden:YES];
            [self.evaluateButton setHidden:YES];
        }
    }
}


#pragma mark - 评价
- (void)evaluateOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailBottomView:evaluateButtonDidClick:)]) {
        [self.delegate OrderDetailBottomView:self evaluateButtonDidClick:self.orderModel];
    }
}


#pragma mark - 申请售后
- (void)afterSaleOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailBottomView:afterSaleButtonDidClick:)]) {
        [self.delegate OrderDetailBottomView:self afterSaleButtonDidClick:self.orderModel];
    }
}

#pragma mark - 取消订单
- (void)cancelOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailBottomView:cancelButtonDidClick:)]) {
        [self.delegate OrderDetailBottomView:self cancelButtonDidClick:self.orderModel];
    }
}

#pragma mark - 确认收货
- (void)confirmOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailBottomView:confirmOrderButtonDidClick:)]) {
        [self.delegate OrderDetailBottomView:self confirmOrderButtonDidClick:self.orderModel];
    }
}

#pragma mark - 申请退款
- (void)refundOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailBottomView:refundButtonDidClick:)]) {
        [self.delegate OrderDetailBottomView:self refundButtonDidClick:self.orderModel];
    }
}

#pragma mark - 支付订单
- (void)payOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailBottomView:payButtonDidClick:)]) {
        [self.delegate OrderDetailBottomView:self payButtonDidClick:self.orderModel];
    }
}

#pragma mark - 删除订单
- (void)deleteOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailBottomView:deleteButtonDidClick:)]) {
        [self.delegate OrderDetailBottomView:self deleteButtonDidClick:self.orderModel];
    }
}

#pragma mark - 取消申请按钮
- (void)cancelRefundButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailBottomView:cancelRefundButtonDidClick:)]) {
        [self.delegate OrderDetailBottomView:self cancelRefundButtonDidClick:self.orderModel];
    }
}

#pragma mark - 查看申请售后进度按钮
- (void)checkAfterSaleButtonButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailBottomView:checkAfterSaleButtonDidClick:)]) {
        [self.delegate OrderDetailBottomView:self checkAfterSaleButtonDidClick:self.orderModel];
    }
}

#pragma mark - lazy
- (UIButton *)checkAfterSaleButton {
    if (!_checkAfterSaleButton) {
        _checkAfterSaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkAfterSaleButton setTitle:@"查看进度" forState:UIControlStateNormal];
        [_checkAfterSaleButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_checkAfterSaleButton.titleLabel setFont:KFont(14)];
        [_checkAfterSaleButton.layer setMasksToBounds:YES];
        [_checkAfterSaleButton.layer setCornerRadius:14];
        [_checkAfterSaleButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_checkAfterSaleButton.layer setBorderWidth:1];
        [_checkAfterSaleButton addTarget:self action:@selector(checkAfterSaleButtonButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_checkAfterSaleButton setHidden:YES];
    }
    return _checkAfterSaleButton;
}

- (UIButton *)cancelRefundButton {
    if (!_cancelRefundButton) {
        _cancelRefundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelRefundButton setTitle:@"取消申请" forState:UIControlStateNormal];
        [_cancelRefundButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_cancelRefundButton.titleLabel setFont:KFont(14)];
        [_cancelRefundButton.layer setMasksToBounds:YES];
        [_cancelRefundButton.layer setCornerRadius:14];
        [_cancelRefundButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_cancelRefundButton.layer setBorderWidth:1];
        [_cancelRefundButton addTarget:self action:@selector(cancelRefundButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelRefundButton setHidden:YES];
    }
    return _cancelRefundButton;
}

- (UIButton *)evaluateButton {
    if (!_evaluateButton) {
        _evaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_evaluateButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_evaluateButton setTitle:@"评价" forState:UIControlStateNormal];
        [_evaluateButton.titleLabel setFont:KFont(14)];
        [_evaluateButton.layer setMasksToBounds:YES];
        [_evaluateButton.layer setCornerRadius:14];
        [_evaluateButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_evaluateButton.layer setBorderWidth:1];
        [_evaluateButton addTarget:self action:@selector(evaluateOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_evaluateButton setHidden:YES];
    }
    return _evaluateButton;
}

- (UIButton *)afterSaleButton {
    if (!_afterSaleButton) {
        _afterSaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_afterSaleButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_afterSaleButton setTitle:@"申请售后" forState:UIControlStateNormal];
        [_afterSaleButton.titleLabel setFont:KFont(14)];
        [_afterSaleButton.layer setMasksToBounds:YES];
        [_afterSaleButton.layer setCornerRadius:14];
        [_afterSaleButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_afterSaleButton.layer setBorderWidth:1];
        [_afterSaleButton addTarget:self action:@selector(afterSaleOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_afterSaleButton setHidden:YES];
    }
    return _afterSaleButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:KFont(14)];
        [_cancelButton.layer setMasksToBounds:YES];
        [_cancelButton.layer setCornerRadius:14];
        [_cancelButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_cancelButton.layer setBorderWidth:1];
        [_cancelButton addTarget:self action:@selector(cancelOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setHidden:YES];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_confirmButton setTitle:@"确认收货" forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:KFont(14)];
        [_confirmButton.layer setMasksToBounds:YES];
        [_confirmButton.layer setCornerRadius:14];
        [_confirmButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_confirmButton.layer setBorderWidth:1];
        [_confirmButton addTarget:self action:@selector(confirmOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setHidden:YES];
    }
    return _confirmButton;
}

- (UIButton *)refundButton {
    if (!_refundButton) {
        _refundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refundButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_refundButton setTitle:@"申请退款" forState:UIControlStateNormal];
        [_refundButton.titleLabel setFont:KFont(14)];
        [_refundButton.layer setMasksToBounds:YES];
        [_refundButton.layer setCornerRadius:14];
        [_refundButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_refundButton.layer setBorderWidth:1];
        [_refundButton addTarget:self action:@selector(refundOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_refundButton setHidden:YES];
    }
    return _refundButton;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_payButton setTitle:@"支付订单" forState:UIControlStateNormal];
        [_payButton.titleLabel setFont:KFont(14)];
        [_payButton.layer setMasksToBounds:YES];
        [_payButton.layer setCornerRadius:14];
        [_payButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_payButton.layer setBorderWidth:1];
        [_payButton addTarget:self action:@selector(payOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_payButton setHidden:YES];
    }
    return _payButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_deleteButton setTitle:@"删除订单" forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont:KFont(14)];
        [_deleteButton.layer setMasksToBounds:YES];
        [_deleteButton.layer setCornerRadius:14];
        [_deleteButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_deleteButton.layer setBorderWidth:1];
        [_deleteButton addTarget:self action:@selector(deleteOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setHidden:YES];
    }
    return _deleteButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
