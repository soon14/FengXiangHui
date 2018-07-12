//
//  AccountView.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AccountView.h"

@implementation AccountView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        //
        [self addSubview:self.allSelectButton];
        [self.allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(13);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        //
        UILabel *allSelectLabel = [[UILabel alloc]init];
        [allSelectLabel setTextColor:KUIColorFromHex(0x333333)];
        [allSelectLabel setFont:KFont(16)];
        [allSelectLabel setText:@"全选"];
        [self addSubview:allSelectLabel];
        [allSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_allSelectButton.mas_right).offset(9);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        //
        [self addSubview:self.accountButton];
        [self.accountButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_offset(0);
            make.width.mas_equalTo(106);
        }];
        
        //
        [self addSubview:self.totalPriceLabel];
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.right.mas_equalTo(_accountButton.mas_left).offset(-15);
            make.height.mas_equalTo(25);
        }];
        
        //运费
        [self addSubview:self.freightLabel];
        [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_totalPriceLabel.mas_bottom).offset(0);
            make.right.mas_equalTo(_accountButton.mas_left).offset(-15);
            make.bottom.mas_offset(-2);
        }];
        
        
        //移入收藏
        [self addSubview:self.collectButton];
        [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.right.mas_equalTo(_accountButton.mas_left);
            make.width.mas_equalTo(106);
        }];
        
        //删除
        [self addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_offset(0);
            make.width.mas_equalTo(106);
        }];
        
        
        UIView *line = [[UIView alloc]init];
        [line setBackgroundColor:KUIColorFromHex(0xeeeeee)];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
        
    }
    return self;
}


- (void)buttonAction:(UIButton *)sender {
    if (self.accountViewBlock) {
        self.accountViewBlock(sender.tag);
    }
    if (sender.tag==0) {
        sender.selected = !sender.selected;
        [self.allSelectButton setSelected:sender.selected];
    }
    
}

#pragma mark - lazy
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundColor:KUIColorFromHex(0xff6590)];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont:KFont(16)];
        [_deleteButton setHidden:YES];
        [_deleteButton setTag:3];
        [_deleteButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UIButton *)collectButton {
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectButton setBackgroundColor:KUIColorFromHex(0xff6590)];
        [_collectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_collectButton setTitle:@"移到关注" forState:UIControlStateNormal];
        [_collectButton.titleLabel setFont:KFont(16)];
        [_collectButton setHidden:YES];
        [_collectButton setTag:2];
        [_collectButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectButton;
}

- (UILabel *)totalPriceLabel {
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc]init];
        [_totalPriceLabel setTextColor:KUIColorFromHex(0xff463c)];
        [_totalPriceLabel setFont:KFont(16)];
        [_totalPriceLabel setTextAlignment:NSTextAlignmentRight];
        [_totalPriceLabel setText:@"合计：¥0"];
    }
    return _totalPriceLabel;
}

- (UILabel *)freightLabel {
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc] init];
        [_freightLabel setTextColor:KUIColorFromHex(0x999999)];
        [_freightLabel setFont:KFont(13)];
        [_freightLabel setTextAlignment:NSTextAlignmentRight];
        [_freightLabel setText:@"不含运费"];
    }
    return _freightLabel;
}

- (UIButton *)accountButton {
    if (!_accountButton) {
        _accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_accountButton setBackgroundColor:KUIColorFromHex(0xff5753)];
        [_accountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_accountButton setTitle:@"结算(0)" forState:UIControlStateNormal];
        [_accountButton.titleLabel setFont:KFont(16)];
        [_accountButton setTag:1];
        [_accountButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accountButton;
}

- (UIButton *)allSelectButton {
    if (!_allSelectButton) {
        _allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allSelectButton setImage:[UIImage imageNamed:@"shopCar_btn_check_nor"] forState:UIControlStateNormal];
        [_allSelectButton setImage:[UIImage imageNamed:@"shopCar_btn_check_sel"] forState:UIControlStateSelected];
        [_allSelectButton setTag:0];
        [_allSelectButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
