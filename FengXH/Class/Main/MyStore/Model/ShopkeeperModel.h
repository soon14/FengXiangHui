//
//  ShopkeeperModel.h
//  FengXH
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopkeeperModel : NSObject
//累计佣金
@property(nonatomic,copy)NSString *commission_total;

//可提现佣金
@property(nonatomic,copy)NSString *commission_ok;

//已申请佣金
@property(nonatomic,copy)NSString *commission_apply;
//待打款佣金
@property(nonatomic,copy)NSString *commission_check;
//无效佣金
@property(nonatomic,copy)NSString *commission_fail;
//成功提现佣金
@property(nonatomic,copy)NSString *commission_pay;

//待收货佣金
@property(nonatomic,copy)NSString *commission_wait;
//未结算佣金
@property(nonatomic,copy)NSString *commission_lock;

//是否可提现（底部按钮）
@property(nonatomic,assign)BOOL cansettle;


//(待定)
@property(nonatomic,strong)NSString *commission_charge;

@end
