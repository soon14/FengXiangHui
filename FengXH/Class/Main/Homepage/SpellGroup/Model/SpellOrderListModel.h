//
//  SpellOrderListModel.h
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpellOrderListModel : NSObject
//list列表
@property(nonatomic,strong)NSArray *list;
//每页条数
@property(nonatomic,assign)NSInteger pagesize;
//总数据条数
@property(nonatomic,assign)NSInteger total;

@end


@interface SpellOrderListDataModel : NSObject
//订单id
@property(nonatomic,copy)NSString *orderId;
//订单号
@property(nonatomic,copy)NSString *orderno;
//创建订单时间
@property(nonatomic,copy)NSString *createtime;

@property(nonatomic,copy)NSString *price;
//运费
@property(nonatomic,copy)NSString *freight;

@property(nonatomic,copy)NSString *creditmoney;

@property(nonatomic,copy)NSString *goodid;

@property(nonatomic,copy)NSString *teamid;
//状态 -1已取消  0待付款  1待发货（已付款） 3已完成
@property(nonatomic,assign)NSInteger status;
// 1 拼团购买 
@property(nonatomic,assign)BOOL is_team;

@property(nonatomic,assign)BOOL success;

@property(nonatomic,copy)NSString *openid;
//标题
@property(nonatomic,copy)NSString *title;
//图片
@property(nonatomic,copy)NSString *thumb;
//单位
@property(nonatomic,copy)NSString *units;
//商品数量
@property(nonatomic,copy)NSString *goodsnum;
//拼团买的价格
@property(nonatomic,copy)NSString *groupsprice;
//单买价格
@property(nonatomic,copy)NSString *singleprice;

@property(nonatomic,copy)NSString *verifynum;

@property(nonatomic,assign) NSInteger verifytype;

@property(nonatomic,assign)BOOL isverify;

@property(nonatomic,copy)NSString *uniacid;

@property(nonatomic,copy)NSString *verifycode;

@property(nonatomic,copy)NSString *vnum;
//共多少元
@property(nonatomic,copy)NSString *amount;
//状态
@property(nonatomic,copy)NSString *statusstr;

@property(nonatomic,copy)NSString *statuscss;



@end
