//
//  StoreCommissionCell.m
//  FengXH
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "StoreCommissionCell.h"
#import "StoreModel.h"
@interface StoreCommissionCell()
//成功提现
@property(nonatomic,strong)UILabel *successWithdraw;
//可提现
@property(nonatomic,strong)UILabel *canWithdraw;

@end
@implementation StoreCommissionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KRedColor;
        
        //成功提现佣金
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, KMAINSIZE.width-20, 20)];
        lab1.text=@"成功提现佣金（元）";
        lab1.font=KFont(15);
        lab1.textColor=[UIColor whiteColor];
        [self addSubview:lab1];
        
        [self addSubview:self.successWithdraw];
        [_successWithdraw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(35);
            make.top.mas_equalTo(lab1.mas_bottom).offset(5);
        }];
        
        //可提现佣金
        UILabel *lab2=[[UILabel alloc]init];
        lab2.text=@"可提现的佣金（元）";
        lab2.font=KFont(15);
        lab2.textColor=[UIColor whiteColor];
        [self addSubview:lab2];
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(20);
            make.top.mas_equalTo(self.successWithdraw.mas_bottom).offset(20);
        }];
        
        [self addSubview:self.canWithdraw];
        [_canWithdraw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(20);
            make.top.mas_equalTo(lab2.mas_bottom).offset(5);
        }];

        
        UIButton *commissionBtn=[[UIButton alloc]init];
        [commissionBtn setTitle:@"佣金提现" forState:UIControlStateNormal];
        [commissionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        commissionBtn.layer.borderColor=[UIColor whiteColor].CGColor;
        commissionBtn.layer.borderWidth=1;
        commissionBtn.layer.cornerRadius=15;
        commissionBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
        commissionBtn.layer.shouldRasterize = YES;
        [commissionBtn addTarget:self action:@selector(commissionAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:commissionBtn];
        [commissionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.bottom.mas_offset(-30);
            make.width.mas_offset(90);
            make.height.mas_offset(30);
        }];
        
    }
    return self;
}
-(void)setStoreCommissionData:(StoreModel *)storeCommissionData
{
    _successWithdraw.text=storeCommissionData.successwithdraw;
    _canWithdraw.text=storeCommissionData.canwithdraw;
}
-(void)commissionAction
{
    if (self.commissionBlock) {
        self.commissionBlock();
    }
}
#pragma mark----懒加载
-(UILabel *)successWithdraw
{
    if (!_successWithdraw) {
        _successWithdraw=[[UILabel alloc]init];
        _successWithdraw.font=KFont(30);
        _successWithdraw.textColor=[UIColor whiteColor];
    }
    return _successWithdraw;
}
-(UILabel *)canWithdraw
{
    if (!_canWithdraw) {
        _canWithdraw=[[UILabel alloc]init];
        _canWithdraw.font=KFont(15);
        _canWithdraw.textColor=[UIColor whiteColor];
    }
    return _canWithdraw;
}

@end
