//
//  SpellOrderAfterSaleViewController.h
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@interface SpellOrderAfterSaleViewController : BaseViewController

@property(nonatomic,strong)NSString *orderId;//订单id

@property(nonatomic,copy)NSString *teamId;//拼团id

-(instancetype)initWithType:(NSInteger)type;//0申请售后 1售后详情

@end
