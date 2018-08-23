//
//  ConfirmOrderBottomView.m
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderBottomView.h"

@implementation ConfirmOrderBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.payButton];
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_offset(0);
            make.width.mas_equalTo(106);
        }];
        
        [self addSubview:self.totalPriceLabel];
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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



#pragma mark - action
- (void)buttonAction:(UIButton *)sender {
    if (self.payBlock) {
        self.payBlock(sender);
    }
}

#pragma mark - lazy
- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setBackgroundColor:KRedColor];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payButton.titleLabel setFont:KFont(16)];
        [_payButton setTag:1];
        [_payButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

- (UILabel *)totalPriceLabel {
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc]init];
        [_totalPriceLabel setTextColor:KUIColorFromHex(0x333333)];
        [_totalPriceLabel setFont:KFont(16)];
        [_totalPriceLabel setTextAlignment:NSTextAlignmentRight];
        [_totalPriceLabel setText:@"需付："];
    }
    return _totalPriceLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
