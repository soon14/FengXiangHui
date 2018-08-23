//
//  SpellOrderAfterSaleMoneyCell.m
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderAfterSaleMoneyCell.h"

@implementation SpellOrderAfterSaleMoneyCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //标题
        UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        titleLab.text=@"退款金额";
        titleLab.textColor=KUIColorFromHex(0x333333);
        titleLab.font=KFont(16);
        [self addSubview:titleLab];
        
        
        // ¥
        UILabel *lab=[[UILabel alloc]init];
        lab.textColor=KUIColorFromHex(0x333333);
        lab.font=KFont(16);
        lab.text=@"¥";
        [self addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLab.mas_right).offset(0);
            make.width.mas_offset(20);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_offset(20);
        }];
        
        _moneyTextField=[[UITextField alloc]init];
        _moneyTextField.borderStyle=UITextBorderStyleNone;
        _moneyTextField.keyboardType=UIKeyboardTypeNumberPad;
        _moneyTextField.font=KFont(16);
        [self addSubview:_moneyTextField];
        [_moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lab.mas_right).offset(0);
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_offset(20);
        }];
        
        
    }
    return self;
}

@end
