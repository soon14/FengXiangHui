//
//  GoodsDetailNavigationView.m
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailNavigationView.h"

@interface GoodsDetailNavigationView ()

/** 返回按钮 */
@property(nonatomic , strong)UIButton *backButton;
/** 二维码按钮 */
@property(nonatomic , strong)UIButton *scanCodeButton;

@end

@implementation GoodsDetailNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(6);
            make.bottom.mas_offset(0);
            make.width.height.mas_equalTo(44);
        }];
        
        [self addSubview:self.scanCodeButton];
        [self.scanCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-6);
            make.bottom.mas_offset(0);
            make.width.height.mas_equalTo(44);
        }];
        
        [self addSubview:self.goodsButton];
        [self.goodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_centerX);
            make.bottom.mas_offset(0);
            make.width.mas_equalTo(85);
            make.height.mas_equalTo(44);
        }];
        
        [self addSubview:self.detailsButton];
        [self.detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX);
            make.bottom.mas_offset(0);
            make.width.mas_equalTo(85);
            make.height.mas_equalTo(44);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
        [self addSubview:self.moveLine];
    }
    return self;
}


#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailNavigationView:buttonAction:)]) {
        [self.delegate GoodsDetailNavigationView:self buttonAction:sender.tag];
    }
}

#pragma mark - lazy
- (UIView *)moveLine {
    if (!_moveLine) {
        _moveLine = [[UIView alloc] initWithFrame:CGRectMake((KMAINSIZE.width/2)-55, self.frame.size.height-4, 25, 4)];
        [_moveLine setBackgroundColor:KRedColor];
        [_moveLine.layer setMasksToBounds:YES];
        [_moveLine.layer setCornerRadius:2];
    }
    return _moveLine;
}

- (UIButton *)detailsButton {
    if (!_detailsButton) {
        _detailsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailsButton setTitle:@"详情" forState:UIControlStateNormal];
        [_detailsButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_detailsButton.titleLabel setFont:KFont(15)];
        [_detailsButton setTag:3];
        [_detailsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailsButton;
}

- (UIButton *)goodsButton {
    if (!_goodsButton) {
        _goodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goodsButton setTitle:@"商品" forState:UIControlStateNormal];
        [_goodsButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_goodsButton.titleLabel setFont:KFont(16)];
        [_goodsButton setTag:2];
        [_goodsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goodsButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"goodsDetailBack"] forState:UIControlStateNormal];
        [_backButton setTag:0];
        [_backButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)scanCodeButton {
    if (!_scanCodeButton) {
        _scanCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scanCodeButton setImage:[UIImage imageNamed:@"goodsDetailScanCode"] forState:UIControlStateNormal];
        [_scanCodeButton setTag:1];
        [_scanCodeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanCodeButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
