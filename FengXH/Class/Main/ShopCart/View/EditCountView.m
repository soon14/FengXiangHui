//
//  EditCountView.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "EditCountView.h"

@implementation EditCountView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        
        [self addSubview:self.minusBtn];
        [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(0);
            make.height.width.mas_equalTo(self.mas_height);
        }];
        
        
        [self addSubview:self.plusBtn];
        [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_offset(0);
            make.height.width.mas_equalTo(self.mas_height);
        }];
        
        
        
        [self addSubview:self.numTextField];
        [self.numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.mas_equalTo(_minusBtn.mas_right).offset(0);
            make.right.mas_equalTo(_plusBtn.mas_left).offset(0);
        }];
        
    }
    return self;
}


- (UITextField *)numTextField {
    if (!_numTextField) {
        _numTextField = [[UITextField alloc]init];
        [_numTextField setTextColor:[UIColor darkGrayColor]];
        [_numTextField setTintColor:[UIColor darkGrayColor]];
        [_numTextField setFont:KFont(13)];
        [_numTextField setTextAlignment:NSTextAlignmentCenter];
        [_numTextField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return _numTextField;
}

- (UIButton *)plusBtn {
    if (!_plusBtn) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setShowsTouchWhenHighlighted:YES];
        [_plusBtn setImage:[UIImage imageNamed:@"global_btn_nember_add"] forState:UIControlStateNormal];
    }
    return _plusBtn;
}

- (UIButton *)minusBtn {
    if (!_minusBtn) {
        _minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusBtn setShowsTouchWhenHighlighted:YES];
        [_minusBtn setImage:[UIImage imageNamed:@"global_btn_nember_sub"] forState:UIControlStateNormal];
    }
    return _minusBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
