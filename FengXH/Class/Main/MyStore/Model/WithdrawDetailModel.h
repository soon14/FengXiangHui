//
//  WithdrawDetailModel.h
//  FengXH
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WithdrawDetailModel : NSObject
//预计佣金
@property(nonatomic,copy)NSString *commissioncount;
//list
@property(nonatomic,strong)NSArray *list;
//每页条数
@property(nonatomic,assign)NSInteger pagesize;
//总数据条数
@property(nonatomic,assign)NSInteger total;

@end


@interface WithdrawDetailDataModel : NSObject
//id
@property(nonatomic,copy)NSString *withdrawDetailId;
// 0/提现到余额 1/提现到微信红包 2提现到支付宝 3/提现到银行卡
@property(nonatomic,assign)NSInteger type;
//时间
@property(nonatomic,copy)NSString *dealtime;
//状态 1待审核 2待打款 3已打款 -1无效 -2驳回
@property(nonatomic,copy)NSString *status;
//金额
@property(nonatomic,copy)NSString *commission_pay;
//状态描述
@property(nonatomic,copy)NSString *statusstr;
//申请
@property(nonatomic,copy)NSString *texts;
//实际金额
@property(nonatomic,copy)NSString *commission;
//手续费
@property(nonatomic,copy)NSString *deductionmoney;
//申请金额
@property(nonatomic,copy)NSString *fact_price;


@end
