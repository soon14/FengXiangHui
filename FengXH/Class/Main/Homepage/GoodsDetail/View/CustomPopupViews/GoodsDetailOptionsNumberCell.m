//
//  GoodsDetailOptionsNumberCell.m
//  FengXH
//
//  Created by sun on 2018/9/20.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailOptionsNumberCell.h"

@interface GoodsDetailOptionsNumberCell ()<UITextFieldDelegate>

@property(nonatomic , strong)UIButton *minusButton;//减
@property(nonatomic , strong)UIButton *plusButton;//加

@end

@implementation GoodsDetailOptionsNumberCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        UILabel *label = [[UILabel alloc]init];
        [label setText:@"购买数量"];
        [label setTextColor:KUIColorFromHex(0x333333)];
        [label setFont:KFont(14)];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(60);
        }];
        
        [self.contentView addSubview:self.plusButton];
        [self.plusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(30);
        }];
        
        [self.contentView addSubview:self.numTextField];
        [self.numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_plusButton.mas_left);
            make.height.mas_equalTo(25);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(60);
        }];
        
        [self.contentView addSubview:self.minusButton];
        [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_numTextField.mas_left);
            make.height.mas_equalTo(25);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(30);
        }];
        
        
    }
    return self;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([textField.text integerValue] > 99) {
        [self.numTextField setText:@"99"];
    } else if ([textField.text integerValue] < 1) {
        [self.numTextField setText:@"1"];
    }
    [self.numTextField setText:[NSString stringWithFormat:@"%ld",(long)[self.numTextField.text integerValue]]];
    return YES;
}

- (void)plusButtonAction {
    NSInteger i = [self.numTextField.text integerValue];
    if (i < 99) {
        i++;
        [self.numTextField setText:[NSString stringWithFormat:@"%ld",(long)i]];
    }
}

- (void)minusButtonAction {
    NSInteger i = [self.numTextField.text integerValue];
    if (i > 1) {
        i--;
        [self.numTextField setText:[NSString stringWithFormat:@"%ld",(long)i]];
    }
}

#pragma mark - lazy
- (UITextField *)numTextField {
    if (!_numTextField) {
        _numTextField = [[UITextField alloc]init];
        [_numTextField setTextColor:KUIColorFromHex(0x333333)];
        [_numTextField setTintColor:KUIColorFromHex(0x333333)];
        [_numTextField setFont:KFont(14)];
        [_numTextField setTextAlignment:NSTextAlignmentCenter];
        [_numTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [_numTextField setText:@"1"];
        [_numTextField setDelegate:self];
//        [_numTextField setBackgroundColor:KTableBackgroundColor];
    }
    return _numTextField;
}

- (UIButton *)plusButton {
    if (!_plusButton) {
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusButton setImage:[UIImage imageNamed:@"plusButton"] forState:UIControlStateNormal];
        [_plusButton addTarget:self action:@selector(plusButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusButton;
}

- (UIButton *)minusButton {
    if (!_minusButton) {
        _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusButton setImage:[UIImage imageNamed:@"minusButton"] forState:UIControlStateNormal];
        [_minusButton addTarget:self action:@selector(minusButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusButton;
}

@end
