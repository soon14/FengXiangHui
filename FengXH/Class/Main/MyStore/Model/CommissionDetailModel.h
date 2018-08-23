//
//  CommissionDetailModel.h
//  FengXH
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CommissionDetailBuyerModel,CommissionDetailOrderGoodsModel;

@interface CommissionDetailModel : NSObject
//累计佣金
@property(nonatomic,copy)NSString *commission_total;
//佣金list
@property(nonatomic,strong)NSArray *list;
//每页条数
@property(nonatomic,assign)NSInteger pagesize;
//总数据条数
@property(nonatomic,assign)NSInteger totalcount;

@end

@interface CommissionDetailListModel : NSObject

@property(nonatomic,strong)CommissionDetailBuyerModel *buyer;
//预计佣金
@property(nonatomic,copy)NSString *commission;
//下单时间
@property(nonatomic,copy)NSString *createtime;
//id
@property(nonatomic,copy)NSString *buyerId;
//等级
@property(nonatomic,copy)NSString *level;

@property(nonatomic,strong)NSArray *order_goods;
//订单号
@property(nonatomic,copy)NSString *ordersn;
//状态
@property(nonatomic,copy)NSString *status;

@end

@interface CommissionDetailBuyerModel : NSObject
//头像
@property(nonatomic,copy)NSString *avatar;
//昵称
@property(nonatomic,copy)NSString *nickname;

@end

@interface CommissionDetailOrderGoodsModel : NSObject
//预计
@property(nonatomic,copy)NSString *commission;
//商品id
@property(nonatomic,copy)NSString *goodsid;
//id
@property(nonatomic,copy)NSString *orderGoodsId;
//价格
@property(nonatomic,copy)NSString *price;
//商品图片
@property(nonatomic,copy)NSString *thumb;
//商品标题
@property(nonatomic,copy)NSString *title;
//数量
@property(nonatomic,copy)NSString *total;

@end
