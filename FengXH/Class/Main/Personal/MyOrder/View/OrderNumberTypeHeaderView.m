//
//  OrderNumberTypeHeaderView.m
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderNumberTypeHeaderView.h"
#import "MyOrderResultModel.h"

@interface OrderNumberTypeHeaderView ()

/** 订单号 */
@property(nonatomic , strong)UILabel *orderNumberLabel;
/** 订好状态 */
@property(nonatomic , strong)UILabel *orderStatusLabel;

@end

@implementation OrderNumberTypeHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = KTableBackgroundColor;
        
        UIView *backView = [[UIView alloc] init];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.top.mas_offset(10);
        }];
        
        [backView addSubview:self.orderNumberLabel];
        [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.mas_equalTo(backView.mas_centerY);
        }];
        
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        [arrowImageView setImage:[UIImage imageNamed:@"personal_icon_arrow"]];
        [backView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(backView.mas_centerY);
        }];
        
        [backView addSubview:self.orderStatusLabel];
        [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(arrowImageView.mas_left).offset(-10);
            make.centerY.mas_equalTo(backView.mas_centerY);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [backView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.bottom.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)setOrderModel:(MyOrderResultListModel *)orderModel {
    _orderModel = orderModel;
    [self.orderStatusLabel setText:_orderModel.statusstr];
    [self.orderNumberLabel setText:[NSString stringWithFormat:@"订单号：%@",_orderModel.ordersn]];
}


#pragma mark - lazy
- (UILabel *)orderStatusLabel {
    if (!_orderStatusLabel) {
        _orderStatusLabel = [[UILabel alloc] init];
        [_orderStatusLabel setTextColor:KUIColorFromHex(0x666666)];
        [_orderStatusLabel setFont:KFont(14)];
//        [_orderStatusLabel setText:@"待付款"];
    }
    return _orderStatusLabel;
}

- (UILabel *)orderNumberLabel {
    if (!_orderNumberLabel) {
        _orderNumberLabel = [[UILabel alloc] init];
        [_orderNumberLabel setTextColor:KUIColorFromHex(0x666666)];
        [_orderNumberLabel setFont:KFont(14)];
//        [_orderNumberLabel setText:@"订单号：12412412412"];
    }
    return _orderNumberLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
