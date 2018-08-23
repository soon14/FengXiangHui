//
//  SpellOrderDetailViewController.h
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@interface SpellOrderDetailViewController : BaseViewController

@property(nonatomic,assign)NSInteger selectSectionIndex;//上个页面选中的cell

@property(nonatomic,assign)NSInteger controllerType;//上个页面的controller

@property(nonatomic,copy)NSString *orderId;//订单id

@property(nonatomic,copy)NSString *teamId;//拼团id

-(instancetype)initWithType:(NSInteger)type;//0待付款 1待发货 2待收货 3已完成 -1已取消

@end
