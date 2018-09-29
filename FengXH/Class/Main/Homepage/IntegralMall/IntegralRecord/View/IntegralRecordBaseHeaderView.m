//
//  IntegralRecordBaseHeaderView.m
//  FengXH
//
//  Created by sun on 2018/9/26.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordBaseHeaderView.h"

@implementation IntegralRecordBaseHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat ButtonWidth = (KMAINSIZE.width/3);
        
        [self addSubview:self.allRecordButton];
        [self.allRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_offset(0);
            make.width.mas_equalTo(ButtonWidth);
        }];
        
        [self addSubview:self.exchangeButton];
        [self.exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.mas_equalTo(_allRecordButton.mas_right);
            make.width.mas_equalTo(ButtonWidth);
        }];
        
        [self addSubview:self.winnerButton];
        [self.winnerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_offset(0);
            make.width.mas_equalTo(ButtonWidth);
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


#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.headerBlock) {
        self.headerBlock(sender.tag);
    }
}


#pragma mark - lazy
- (UIView *)moveLine {
    if (!_moveLine) {
        _moveLine = [[UIView alloc]initWithFrame:CGRectMake(40, 40, KMAINSIZE.width/3-80, 2)];
        [_moveLine setBackgroundColor:KRedColor];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_moveLine.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _moveLine.bounds;
        maskLayer.path = maskPath.CGPath;
        _moveLine.layer.mask = maskLayer;
    }
    return _moveLine;
}

- (UIButton *)winnerButton {
    if (!_winnerButton) {
        _winnerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_winnerButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_winnerButton setTitle:@"中奖记录" forState:UIControlStateNormal];
        [_winnerButton.titleLabel setFont:KFont(15)];
        [_winnerButton setTag:2];
        [_winnerButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _winnerButton;
}

- (UIButton *)exchangeButton {
    if (!_exchangeButton) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_exchangeButton setTitle:@"兑换记录" forState:UIControlStateNormal];
        [_exchangeButton.titleLabel setFont:KFont(15)];
        [_exchangeButton setTag:1];
        [_exchangeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeButton;
}

- (UIButton *)allRecordButton {
    if (!_allRecordButton) {
        _allRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allRecordButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_allRecordButton setTitle:@"全部记录" forState:UIControlStateNormal];
        [_allRecordButton.titleLabel setFont:KFont(15)];
        [_allRecordButton setTag:0];
        [_allRecordButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allRecordButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
