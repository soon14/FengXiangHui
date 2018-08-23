//
//  PersonalFooterView.m
//  FengXH
//
//  Created by sun on 2018/7/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalFooterView.h"

@interface PersonalFooterView ()

/** 修改密码 */
@property(nonatomic , strong)UIButton *changePasswordButton;
/** 退出登录 */
@property(nonatomic , strong)UIButton *logoutButton;

@end

@implementation PersonalFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KTableBackgroundColor;
        
        [self addSubview:self.changePasswordButton];
        [self.changePasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(15);
            make.left.mas_offset(15);
            make.right.mas_offset(-15);
            make.height.mas_equalTo(40);
        }];
        
        [self addSubview:self.logoutButton];
        [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_changePasswordButton.mas_bottom).offset(15);
            make.left.mas_offset(15);
            make.right.mas_offset(-15);
            make.height.mas_equalTo(40);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KUIColorFromHex(0x333333)];
        [label setFont:KFont(11)];
        [label setText:@"版权所有（c）全球优选商城"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_logoutButton.mas_bottom).offset(0);
            make.left.right.bottom.mas_offset(0);
        }];
        
    }
    return self;
}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock(sender.tag);
    }
}


#pragma mark - lazy
- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setBackgroundColor:KRedColor];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logoutButton.titleLabel setFont:KFont(14)];
        [_logoutButton setTag:1];
        [_logoutButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

- (UIButton *)changePasswordButton {
    if (!_changePasswordButton) {
        _changePasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changePasswordButton setBackgroundColor:[UIColor whiteColor]];
        [_changePasswordButton setTitle:@"修改密码" forState:UIControlStateNormal];
        [_changePasswordButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_changePasswordButton.titleLabel setFont:KFont(14)];
        [_changePasswordButton.layer setBorderColor:KRedColor.CGColor];
        [_changePasswordButton.layer setBorderWidth:1];
        [_changePasswordButton setTag:0];
        [_changePasswordButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changePasswordButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
