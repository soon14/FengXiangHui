//
//  SpellOrderDetailModel.h
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SpellOrderDetailAddressModel,SpellOrderDetailGoodsModel;

@interface SpellOrderDetailModel : NSObject

@property(nonatomic,strong)SpellOrderDetailAddressModel *address;

@property(nonatomic,strong)SpellOrderDetailGoodsModel *goods;

//创建时间
@property(nonatomic,copy)NSString *createtime;
//积分抵扣
@property(nonatomic,copy)NSString *creditmoney;
//余额抵扣
@property(nonatomic,copy)NSString *deductcredit2;
//团长优惠
@property(nonatomic,copy)NSString *discount;
//会员优惠
@property(nonatomic,copy)NSString *discountprice;
//运费
@property(nonatomic,copy)NSString *freight;
//商品小计
@property(nonatomic,copy)NSString *maprice;
//订单号
@property(nonatomic,copy)NSString *orderno;
//支付时间
@property(nonatomic,copy)NSString *paytime;
//
@property(nonatomic,assign)NSInteger paytype;
//订单金额(含运费)
@property(nonatomic,copy)NSString *price;
//实付费(含运费)
@property(nonatomic,copy)NSString *price_cc;
//refundstate>0 申请过售后
@property(nonatomic,assign)NSInteger refundstate;
//订单状态字符串
@property(nonatomic,copy)NSString *status;
//订单状态 -1取消状态（交易关闭），0普通状态（没付款: 待付款 ; 付了款: 待发货），1 买家已付款（待发货），2 卖家已发货（待收货），3 成功（可评价: 等待评价 ; 不可评价 : 交易完成）4 退款申请
@property(nonatomic,assign)NSInteger status1;

@end


@interface SpellOrderDetailAddressModel : NSObject
//详细地址
@property(nonatomic,copy)NSString *address;
//区
@property(nonatomic,copy)NSString *area;
//市
@property(nonatomic,copy)NSString *city;
//
@property(nonatomic,copy)NSString *datavalue;
//
@property(nonatomic,copy)NSString *fxh_api;
//
@property(nonatomic,assign)BOOL isdefault;
//电话
@property(nonatomic,copy)NSString *mobile;
//
@property(nonatomic,copy)NSString *openid;
//省
@property(nonatomic,copy)NSString *province;
//姓名
@property(nonatomic,copy)NSString *realname;
//街道
@property(nonatomic,copy)NSString *streetdatavalue;
//
@property(nonatomic,copy)NSString *town;
//
@property(nonatomic,copy)NSString *uniacid;
//
@property(nonatomic,copy)NSString *zipcode;

@end



@interface SpellOrderDetailGoodsModel : NSObject
//
@property(nonatomic,copy)NSString *goodsnum;
//多少
@property(nonatomic,copy)NSString *groupnum;
// 多少元
@property(nonatomic,copy)NSString *groupsprice;
//拼团商品id
@property(nonatomic,copy)NSString *goodsId;
//店铺名
@property(nonatomic,copy)NSString *shopname;
//单买价格
@property(nonatomic,copy)NSString *singleprice;
//已有几人团购
@property(nonatomic,copy)NSString *teamnum;
//
@property(nonatomic,copy)NSString *thumb;
//商品名字
@property(nonatomic,copy)NSString *title;
//单位
@property(nonatomic,copy)NSString *units;

@end
