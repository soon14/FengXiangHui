//
//  WithdrawDetailCell.m
//  FengXH
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "WithdrawDetailCell.h"
#import "WithdrawDetailModel.h"

@interface WithdrawDetailCell ()
//提现
@property(nonatomic,strong)UILabel *withdrawLab;
//时间
@property(nonatomic,strong)UILabel *timeLab;
//提现金额
@property(nonatomic,strong)UILabel *moneyLab;
//提现状态
@property(nonatomic,strong)UILabel *statusLab;
//申请佣金
@property(nonatomic,strong)UILabel *applyCommissionLab;
//实际金额
@property(nonatomic,strong)UILabel *realMoneyLab;
//提现手续费
@property(nonatomic,strong)UILabel *serviceChargeLab;

@end

@implementation WithdrawDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _withdrawLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 20)];
        _withdrawLab.textColor=KUIColorFromHex(0x333333);
        _withdrawLab.font=KFont(16);
        [self addSubview:_withdrawLab];
        
        _timeLab=[[UILabel alloc]init];
        _timeLab.textColor=KUIColorFromHex(0x333333);
        _timeLab.font=KFont(14);
        [self addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_equalTo(_withdrawLab.mas_bottom).offset(5);
            make.height.mas_offset(20);
            make.width.mas_offset(200);
        }];
        
        _moneyLab=[[UILabel alloc]init];
        _moneyLab.textColor=KUIColorFromHex(0x333333);
        _moneyLab.font=KFont(16);
        _moneyLab.textAlignment=NSTextAlignmentRight;
        [self addSubview:_moneyLab];
        [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.mas_offset(10);
            make.height.mas_offset(20);
            make.left.mas_equalTo(_withdrawLab.mas_right).offset(5);
        }];
        
        _statusLab=[[UILabel alloc]init];
        _statusLab.textColor=KUIColorFromHex(0x53B862);
        _statusLab.font=KFont(16);
        _statusLab.textAlignment=NSTextAlignmentRight;
        [self addSubview:_statusLab];
        [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.mas_equalTo(_moneyLab.mas_bottom).offset(5);
            make.height.mas_offset(20);
            make.left.mas_equalTo(_timeLab.mas_right).offset(5);
        }];
        
        //横着的分割线
        UILabel *lineLab=[[UILabel alloc]init];
        lineLab.backgroundColor=KUIColorFromHex(0xb2b2b2);
        [self addSubview:lineLab];
        [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(_timeLab.mas_bottom).offset(5);
            make.height.mas_offset(1);
        }];
        
        NSArray *titleArr=@[@"申请佣金",@"实际金额",@"提现手续费"];
        for (int i=0; i<3; i++) {
            UIView *view=[[UIView alloc]init];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(KMAINSIZE.width/3*i);
                make.width.mas_offset(KMAINSIZE.width/3);
                make.height.mas_offset(60);
                make.top.mas_equalTo(lineLab.mas_bottom).offset(0);
            }];
            
            UILabel *lab=[[UILabel alloc]init];
            lab.font=KFont(16);
            lab.textColor=KUIColorFromHex(0x333333);
            lab.text=titleArr[i];
            lab.textAlignment=NSTextAlignmentCenter;
            [view addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_offset(0);
                make.height.mas_offset(20);
                make.top.mas_offset(10);
            }];
            
            UILabel *lab2=[[UILabel alloc]init];
            lab2.font=KFont(16);
            lab2.textColor=KUIColorFromHex(0x333333);
            lab2.textAlignment=NSTextAlignmentCenter;
            [view addSubview:lab2];
            [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_offset(0);
                make.top.mas_equalTo(lab.mas_bottom).offset(5);
                make.bottom.mas_offset(-5);
            }];
            
            if (i==0||i==1) {
                UILabel *lineLab=[[UILabel alloc]init];
                lineLab.backgroundColor=KUIColorFromHex(0xb2b2b2);
                [view addSubview:lineLab];
                [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_offset(0.5);
                    make.width.mas_offset(1);
                    make.top.mas_offset(10);
                    make.bottom.mas_offset(-10);
                }];
            }
            
            
            
            switch (i) {
                case 0:
                    _applyCommissionLab=lab2;
                    break;
                case 1:
                    _realMoneyLab=lab2;
                    break;
                case 2:
                    _serviceChargeLab=lab2;
                    break;
                default:
                    break;
            }
            
            
        }
        
        
        //底部的查看提现详情部分
        UIView *bottomView=[[UIView alloc]init];
        bottomView.backgroundColor=KUIColorFromHex(0xeeeeee);
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.top.mas_equalTo(lineLab.mas_bottom).offset(60);
        }];
        
        UILabel *bottomLab=[[UILabel alloc]init];
        bottomLab.font=KFont(16);
        bottomLab.textColor=KUIColorFromHex(0x333333);
        bottomLab.textAlignment=NSTextAlignmentCenter;
        bottomLab.text=@"查看提现详情";
        [bottomView addSubview:bottomLab];
        [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bottomView.mas_centerY);
            make.height.mas_offset(20);
            make.left.right.mas_offset(0);
        }];
        
    }
    return self;
}
-(void)setDataModel:(WithdrawDetailDataModel *)dataModel
{
    switch (dataModel.type) {
        case 0:
            _withdrawLab.text=@"提现到余额";
            break;
        case 1:
            _withdrawLab.text=@"提现到微信红包";
            break;
        case 2:
            _withdrawLab.text=@"提现到支付宝";
            break;
        case 3:
            _withdrawLab.text=@"提现到银行卡";
            break;
        default:
            break;
    }
    
    
    
    _timeLab.text=dataModel.dealtime;
    
    _moneyLab.text=[NSString stringWithFormat:@"+%@",dataModel.commission_pay];
    
    _statusLab.text=dataModel.statusstr;
    
    _applyCommissionLab.text=dataModel.fact_price;
    
    _realMoneyLab.text=dataModel.commission;
    
    _serviceChargeLab.text=dataModel.deductionmoney;
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
