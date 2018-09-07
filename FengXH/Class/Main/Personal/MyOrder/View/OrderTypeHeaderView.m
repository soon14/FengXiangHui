//
//  OrderTypeHeaderView.m
//  FengXH
//
//  Created by HubinSun on 2017/10/10.
//  Copyright © 2017年 HubinSun. All rights reserved.
//

#import "OrderTypeHeaderView.h"

@implementation OrderTypeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat buttonWidth = (KMAINSIZE.width/5);
        
        [self addSubview:self.allButton];
        [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
        }];
        
        
        [self addSubview:self.waitPaidButton];
        [self.waitPaidButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_allButton.mas_right);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
        }];
        
        
        [self addSubview:self.waitSendButton];
        [self.waitSendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_waitPaidButton.mas_right);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
        }];
        
        
        [self addSubview:self.waitReceiveButton];
        [self.waitReceiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_waitSendButton.mas_right);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
        }];
        
        
        [self addSubview:self.waitEvaluateButton];
        [self.waitEvaluateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_waitReceiveButton.mas_right);
            make.top.bottom.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
        }];
        
        //小黑线
        UIView *line = [[UIView alloc]init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
        
        [self addSubview:self.moveLine];
        
    }
    return self;
}


- (void)buttonAction:(UIButton *)sender {
    if (self.orderTypeBlock) {
        self.orderTypeBlock(sender.tag-9001);
    }
}

#pragma mark - lazy
- (UIView *)moveLine {
    if (!_moveLine) {
        _moveLine = [[UIView alloc]initWithFrame:CGRectMake(10, 40, KMAINSIZE.width/5-20, 2)];
        [_moveLine setBackgroundColor:KRedColor];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_moveLine.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _moveLine.bounds;
        maskLayer.path = maskPath.CGPath;
        _moveLine.layer.mask = maskLayer;
    }
    return _moveLine;
}

- (UIButton *)waitEvaluateButton {
    if (!_waitEvaluateButton) {
        _waitEvaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_waitEvaluateButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_waitEvaluateButton.titleLabel setFont:KFont(15)];
        [_waitEvaluateButton setTitle:@"已完成" forState:UIControlStateNormal];
        [_waitEvaluateButton setTag:9005];
        [_waitEvaluateButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _waitEvaluateButton;
}

- (UIButton *)waitReceiveButton {
    if (!_waitReceiveButton) {
        _waitReceiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_waitReceiveButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_waitReceiveButton.titleLabel setFont:KFont(15)];
        [_waitReceiveButton setTitle:@"待收货" forState:UIControlStateNormal];
        [_waitReceiveButton setTag:9004];
        [_waitReceiveButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _waitReceiveButton;
}

- (UIButton *)waitSendButton {
    if (!_waitSendButton) {
        _waitSendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_waitSendButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_waitSendButton.titleLabel setFont:KFont(15)];
        [_waitSendButton setTitle:@"待发货" forState:UIControlStateNormal];
        [_waitSendButton setTag:9003];
        [_waitSendButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _waitSendButton;
}

- (UIButton *)waitPaidButton {
    if (!_waitPaidButton) {
        _waitPaidButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_waitPaidButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_waitPaidButton.titleLabel setFont:KFont(15)];
        [_waitPaidButton setTitle:@"待付款" forState:UIControlStateNormal];
        [_waitPaidButton setTag:9002];
        [_waitPaidButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _waitPaidButton;
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allButton setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
        [_allButton.titleLabel setFont:KFont(15)];
        [_allButton setTitle:@"全部" forState:UIControlStateNormal];
        [_allButton setTag:9001];
        [_allButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
