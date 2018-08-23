//
//  OrderSectionFooterView.m
//  FengXH
//
//  Created by sun on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderSectionFooterView.h"
#import "MyOrderResultModel.h"

@interface OrderSectionFooterView ()

/** 支付订单按钮 */
@property(nonatomic , strong)UIButton *payOrderButton;
/** 取消订单按钮 */
@property(nonatomic , strong)UIButton *cancelOrderButton;
/** 删除订单 */
@property(nonatomic , strong)UIButton *deleteOrderButton;
/** 评价 */
@property(nonatomic , strong)UIButton *evaluateButton;
/** 查看物流 */
@property(nonatomic , strong)UIButton *logisticsButton;
/** 确认收货 */
@property(nonatomic , strong)UIButton *confirmOrderButton;
/** 订单商品数量与总价 */
@property(nonatomic , strong)UILabel *orderPriceLabel;

@end

@implementation OrderSectionFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.orderPriceLabel];
        [self.orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(40);
        }];
        
        [self.contentView addSubview:self.payOrderButton];
        [self.payOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.mas_equalTo(_orderPriceLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];

        [self.contentView addSubview:self.cancelOrderButton];
        [self.cancelOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_payOrderButton.mas_left).offset(-10);
            make.centerY.mas_equalTo(_payOrderButton.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];

        //
        [self.contentView addSubview:self.confirmOrderButton];
        [self.confirmOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_payOrderButton.mas_centerY);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        [self.contentView addSubview:self.deleteOrderButton];
        [self.deleteOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_payOrderButton.mas_centerY);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        [self.contentView addSubview:self.logisticsButton];
        [self.logisticsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_payOrderButton.mas_centerY);
            make.right.mas_equalTo(_deleteOrderButton.mas_left).offset(-10);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        [self.contentView addSubview:self.evaluateButton];
        [self.evaluateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_payOrderButton.mas_centerY);
            make.right.mas_equalTo(_logisticsButton.mas_left).offset(-10);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(60);
        }];

        

        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(40);
            make.right.mas_offset(0);
            make.left.mas_offset(10);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)setOrderModel:(MyOrderResultListModel *)orderModel {
    _orderModel = orderModel;
    
    NSString *redString = [NSString stringWithFormat:@"¥%.2f",[_orderModel.price floatValue]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%ld个商品 实付：¥%.2f 元",(long)_orderModel.goods_num,[_orderModel.price floatValue]]];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:KRedColor} range:NSMakeRange(attributedString.length-(redString.length+2), redString.length)];
    [self.orderPriceLabel setAttributedText:attributedString];
//    [self.orderPriceLabel setText:[NSString stringWithFormat:@"共%ld个商品 实付：¥%.2f 元",_orderModel.goods_num,[_orderModel.price floatValue]]];
    
    if ([_orderModel.refundstate integerValue] == 1 || [_orderModel.refundstate integerValue] == 2) {
        //退款状态
        [self.payOrderButton setHidden:YES];
        [self.cancelOrderButton setHidden:YES];
        [self.logisticsButton setHidden:YES];
        [self.deleteOrderButton setHidden:YES];
        [self.evaluateButton setHidden:YES];
        [self.confirmOrderButton setHidden:YES];
    } else {
        if ([_orderModel.status integerValue] == 0) {
            //待付款
            [self.payOrderButton setHidden:NO];
            [self.cancelOrderButton setHidden:NO];
            [self.logisticsButton setHidden:YES];
            [self.deleteOrderButton setHidden:YES];
            [self.evaluateButton setHidden:YES];
            [self.confirmOrderButton setHidden:YES];
        } else if ([_orderModel.status integerValue] == 1) {
            //待发货
            [self.payOrderButton setHidden:YES];
            [self.cancelOrderButton setHidden:YES];
            [self.logisticsButton setHidden:YES];
            [self.deleteOrderButton setHidden:YES];
            [self.evaluateButton setHidden:YES];
            [self.confirmOrderButton setHidden:YES];
        } else if ([_orderModel.status integerValue] == 2) {
            //待收货
            [self.payOrderButton setHidden:YES];
            [self.cancelOrderButton setHidden:YES];
            [self.logisticsButton setHidden:NO];
            [self.deleteOrderButton setHidden:YES];
            [self.evaluateButton setHidden:YES];
            [self.confirmOrderButton setHidden:NO];
        } else if ([_orderModel.status integerValue] == 3) {
            //已完成
            [self.payOrderButton setHidden:YES];
            [self.cancelOrderButton setHidden:YES];
            [self.logisticsButton setHidden:NO];
            [self.deleteOrderButton setHidden:NO];
            [self.evaluateButton setHidden:NO];
            [self.confirmOrderButton setHidden:YES];
        } else {
            //已取消
            [self.payOrderButton setHidden:YES];
            [self.cancelOrderButton setHidden:YES];
            [self.logisticsButton setHidden:YES];
            [self.deleteOrderButton setHidden:NO];
            [self.evaluateButton setHidden:YES];
            [self.confirmOrderButton setHidden:YES];
        }
    }
}

#pragma mark - 确认收货
- (void)confirmOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderSectionFooterView:confirmOrderButtonDidClick:)]) {
        [self.delegate OrderSectionFooterView:self confirmOrderButtonDidClick:self.orderModel];
    }

}

#pragma mark - 支付按钮
- (void)payOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderSectionFooterView:payButtonDidClick:)]) {
        [self.delegate OrderSectionFooterView:self payButtonDidClick:self.orderModel];
    }
}

#pragma mark - 取消按钮
- (void)cancelOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderSectionFooterView:cancelButtonDidClick:)]) {
        [self.delegate OrderSectionFooterView:self cancelButtonDidClick:self.orderModel];
    }
}

#pragma mark - 查看物流按钮触发
- (void)logisticsButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderSectionFooterView:logisticsButtonDidClick:)]) {
        [self.delegate OrderSectionFooterView:self logisticsButtonDidClick:self.orderModel];
    }
}

#pragma mark -  评价按钮触发
- (void)evaluateButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderSectionFooterView:evaluateButtonDidClick:)]) {
        [self.delegate OrderSectionFooterView:self evaluateButtonDidClick:self.orderModel];
    }
}

#pragma mark - 删除订单按钮触发
- (void)deleteOrderButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderSectionFooterView:deleteButtonDidClick:)]) {
        [self.delegate OrderSectionFooterView:self deleteButtonDidClick:self.orderModel];
    }
}

#pragma mark - lazy
- (UILabel *)orderPriceLabel {
    if (!_orderPriceLabel) {
        _orderPriceLabel = [[UILabel alloc] init];
        [_orderPriceLabel setTextColor:KUIColorFromHex(0x333333)];
        [_orderPriceLabel setFont:KFont(14)];
        [_orderPriceLabel setTextAlignment:NSTextAlignmentRight];
//        [_orderPriceLabel setText:@"共1个商品 实付：100元"];
    }
    return _orderPriceLabel;
}

- (UIButton *)logisticsButton {
    if (!_logisticsButton) {
        _logisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logisticsButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_logisticsButton setTitle:@"查看物流" forState:UIControlStateNormal];
        [_logisticsButton.titleLabel setFont:KFont(14)];
        [_logisticsButton.layer setMasksToBounds:YES];
        [_logisticsButton.layer setCornerRadius:14];
        [_logisticsButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_logisticsButton.layer setBorderWidth:1];
        [_logisticsButton addTarget:self action:@selector(logisticsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_logisticsButton setHidden:YES];
    }
    return _logisticsButton;
}

- (UIButton *)confirmOrderButton {
    if (!_confirmOrderButton) {
        _confirmOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmOrderButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_confirmOrderButton setTitle:@"确认收货" forState:UIControlStateNormal];
        [_confirmOrderButton.titleLabel setFont:KFont(14)];
        [_confirmOrderButton.layer setMasksToBounds:YES];
        [_confirmOrderButton.layer setCornerRadius:14];
        [_confirmOrderButton.layer setBorderColor:KRedColor.CGColor];
        [_confirmOrderButton.layer setBorderWidth:1];
        [_confirmOrderButton addTarget:self action:@selector(confirmOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmOrderButton setHidden:YES];
    }
    return _confirmOrderButton;
}

- (UIButton *)evaluateButton {
    if (!_evaluateButton) {
        _evaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_evaluateButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_evaluateButton setTitle:@"评价" forState:UIControlStateNormal];
        [_evaluateButton.titleLabel setFont:KFont(14)];
        [_evaluateButton.layer setMasksToBounds:YES];
        [_evaluateButton.layer setCornerRadius:14];
        [_evaluateButton.layer setBorderColor:KRedColor.CGColor];
        [_evaluateButton.layer setBorderWidth:1];
        [_evaluateButton addTarget:self action:@selector(evaluateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_evaluateButton setHidden:YES];
    }
    return _evaluateButton;
}

- (UIButton *)deleteOrderButton {
    if (!_deleteOrderButton) {
        _deleteOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteOrderButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_deleteOrderButton setTitle:@"删除订单" forState:UIControlStateNormal];
        [_deleteOrderButton.titleLabel setFont:KFont(14)];
        [_deleteOrderButton.layer setMasksToBounds:YES];
        [_deleteOrderButton.layer setCornerRadius:14];
        [_deleteOrderButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_deleteOrderButton.layer setBorderWidth:1];
        [_deleteOrderButton addTarget:self action:@selector(deleteOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteOrderButton setHidden:YES];
    }
    return _deleteOrderButton;
}

- (UIButton *)cancelOrderButton {
    if (!_cancelOrderButton) {
        _cancelOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelOrderButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_cancelOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelOrderButton.titleLabel setFont:KFont(14)];
        [_cancelOrderButton.layer setMasksToBounds:YES];
        [_cancelOrderButton.layer setCornerRadius:14];
        [_cancelOrderButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_cancelOrderButton.layer setBorderWidth:1];
        [_cancelOrderButton addTarget:self action:@selector(cancelOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelOrderButton setHidden:YES];
    }
    return _cancelOrderButton;
}

- (UIButton *)payOrderButton {
    if (!_payOrderButton) {
        _payOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payOrderButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_payOrderButton setTitle:@"支付订单" forState:UIControlStateNormal];
        [_payOrderButton.titleLabel setFont:KFont(14)];
        [_payOrderButton.layer setMasksToBounds:YES];
        [_payOrderButton.layer setCornerRadius:14];
        [_payOrderButton.layer setBorderColor:KRedColor.CGColor];
        [_payOrderButton.layer setBorderWidth:1];
        [_payOrderButton addTarget:self action:@selector(payOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_payOrderButton setHidden:YES];
    }
    return _payOrderButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
