//
//  PaySuccessFooterView.m
//  FengXH
//
//  Created by sun on 2018/8/21.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PaySuccessFooterView.h"

@interface PaySuccessFooterView ()

/** 返回按钮 */
@property(nonatomic , strong)UIButton *backButton;

@end

@implementation PaySuccessFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(40);
        }];
        
    }
    return self;
}


#pragma mark - action
- (void)backButtonAction:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock(sender);
    }
}

#pragma mark - lazy
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_backButton.titleLabel setFont:KFont(15)];
        [_backButton.layer setMasksToBounds:YES];
        [_backButton.layer setCornerRadius:20];
        [_backButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_backButton.layer setBorderWidth:1];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
