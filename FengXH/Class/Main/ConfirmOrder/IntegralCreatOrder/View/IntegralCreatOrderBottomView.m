//
//  IntegralCreatOrderBottomView.m
//  FengXH
//
//  Created by sun on 2018/8/22.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "IntegralCreatOrderBottomView.h"
#import "IntegralCreatOrderResultModel.h"

@interface IntegralCreatOrderBottomView ()

/** 需付 */
@property(nonatomic , strong)UILabel *priceLabel;
/** 支付按钮 */
@property(nonatomic , strong)UIButton *payButton;

@end

@implementation IntegralCreatOrderBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.payButton];
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_offset(0);
            make.width.mas_equalTo(106);
        }];
        
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.right.mas_equalTo(_payButton.mas_left).offset(-15);
        }];
        
        UIView *line = [[UIView alloc]init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setResultModel:(IntegralCreatOrderResultModel *)resultModel {
    _resultModel = resultModel;
    [self.priceLabel setText:[NSString stringWithFormat:@"需付(含运费)：%@",_resultModel.price?_resultModel.price:@""]];
}

#pragma mark - payButtonAction
- (void)payButtonAction:(UIButton *)sender {
    if (self.integralPayBlock) {
        self.integralPayBlock(sender);
    }
}

#pragma mark - lazy
- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"支付" forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payButton setBackgroundColor:KRedColor];
        [_payButton.titleLabel setFont:KFont(16)];
        [_payButton addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor:KUIColorFromHex(0x666666)];
        [_priceLabel setFont:KFont(15)];
    }
    return _priceLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
