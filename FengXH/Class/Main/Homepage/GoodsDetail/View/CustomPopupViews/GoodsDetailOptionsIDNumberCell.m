//
//  GoodsDetailOptionsIDCell.m
//  FengXH
//
//  Created by sun on 2018/9/20.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailOptionsIDNumberCell.h"


@implementation GoodsDetailOptionsIDNumberCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KUIColorFromHex(0x333333)];
        [label setFont:KFont(14)];
        [label setText:@"身份证"];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(50);
        }];
        
        [self.contentView addSubview:self.IDTextField];
        [self.IDTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.mas_equalTo(label.mas_right).offset(20);
            make.right.mas_offset(-20);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:KUserIDCardNumber]) {
            [self.IDTextField setText:[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:KUserIDCardNumber] stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"]]];
        }
    }
    return self;
}


#pragma mark - lazy
- (UITextField *)IDTextField {
    if (!_IDTextField) {
        _IDTextField = [[UITextField alloc] init];
        [_IDTextField setTextColor:KUIColorFromHex(0x333333)];
        [_IDTextField setFont:KFont(14)];
        [_IDTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_IDTextField setPlaceholder:@"请输入身份证号码（用于清关）"];        
    }
    return _IDTextField;
}

@end
