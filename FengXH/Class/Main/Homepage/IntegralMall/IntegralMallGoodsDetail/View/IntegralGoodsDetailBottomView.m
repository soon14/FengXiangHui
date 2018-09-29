//
//  IntegralGoodsDetailBottomView.m
//  FengXH
//
//  Created by sun on 2018/9/29.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralGoodsDetailBottomView.h"
#import "IntegralGoodsDetailResultModel.h"

@interface IntegralGoodsDetailBottomView ()

/** button */
@property(nonatomic , strong)UIButton *exchangeButton;

@end

@implementation IntegralGoodsDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.exchangeButton];
        [self.exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo(50);
        }];
        
    }
    return self;
}

- (void)setDetailResultModel:(IntegralGoodsDetailResultModel *)detailResultModel {
    _detailResultModel = detailResultModel;
    [self.exchangeButton setTitle:_detailResultModel.canbuy?@"立即兑换":_detailResultModel.buymsg forState:UIControlStateNormal];
    [self.exchangeButton setEnabled:_detailResultModel.canbuy];
    [self.exchangeButton setBackgroundColor:_detailResultModel.canbuy?KRedColor:KTableBackgroundColor];
    [self.exchangeButton setTitleColor:_detailResultModel.canbuy?[UIColor whiteColor]:KUIColorFromHex(0x999999) forState:UIControlStateNormal];
}

#pragma mark - action
- (void)buttonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(IntegralGoodsDetailBottomView:)]) {
        [self.delegate IntegralGoodsDetailBottomView:self];
    }
}

#pragma mark - lazy
- (UIButton *)exchangeButton {
    if (!_exchangeButton) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeButton setBackgroundColor:KTableBackgroundColor];
        [_exchangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exchangeButton.titleLabel setFont:KFont(16)];
        [_exchangeButton setEnabled:NO];
        [_exchangeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
