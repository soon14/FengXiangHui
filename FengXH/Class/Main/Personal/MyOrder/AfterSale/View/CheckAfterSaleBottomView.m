//
//  CheckAfterSaleBottomView.m
//  FengXH
//
//  Created by sun on 2018/8/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "CheckAfterSaleBottomView.h"

@interface CheckAfterSaleBottomView ()

/** 修改申请 */
@property(nonatomic , strong)UIButton *changeApplyButton;
/** 取消申请 */
@property(nonatomic , strong)UIButton *cancelAppleButton;

@end

@implementation CheckAfterSaleBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.cancelAppleButton];
        [self.cancelAppleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
        [self addSubview:self.changeApplyButton];
        [self.changeApplyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_cancelAppleButton.mas_left).offset(-12);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(80);
        }];
        
    }
    return self;
}


#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.viewBlock) {
        self.viewBlock(sender.tag);
    }
}

#pragma mark - lazy
- (UIButton *)cancelAppleButton {
    if (!_cancelAppleButton) {
        _cancelAppleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelAppleButton setTitle:@"取消申请" forState:UIControlStateNormal];
        [_cancelAppleButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_cancelAppleButton.titleLabel setFont:KFont(14)];
        [_cancelAppleButton.layer setMasksToBounds:YES];
        [_cancelAppleButton.layer setCornerRadius:14];
        [_cancelAppleButton.layer setBorderColor:KUIColorFromHex(0x666666).CGColor];
        [_cancelAppleButton.layer setBorderWidth:1];
        [_cancelAppleButton setTag:0];
        [_cancelAppleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelAppleButton;
}


- (UIButton *)changeApplyButton {
    if (!_changeApplyButton) {
        _changeApplyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeApplyButton setTitle:@"修改申请" forState:UIControlStateNormal];
        [_changeApplyButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_changeApplyButton.titleLabel setFont:KFont(14)];
        [_changeApplyButton.layer setMasksToBounds:YES];
        [_changeApplyButton.layer setCornerRadius:14];
        [_changeApplyButton.layer setBorderColor:KRedColor.CGColor];
        [_changeApplyButton.layer setBorderWidth:1];
        [_changeApplyButton setTag:1];
        [_changeApplyButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeApplyButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
