//
//  MyOrderModel.h
//  FengXH
//
//  Created by sun on 2018/7/20.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderResultModel : NSObject

/** list */
@property(nonatomic , strong)NSArray *list;

@end


@interface MyOrderResultListModel : NSObject

/** id */
@property(nonatomic , copy)NSString *order_id;
/** 地址 id */
@property(nonatomic , copy)NSString *addressid;
/** 订单号 */
@property(nonatomic , copy)NSString *ordersn;
/** 实付金额 */
@property(nonatomic , copy)NSString *price;
/** 是父订单 0否 1是 */
@property(nonatomic , copy)NSString *isparent;
/** 运费 */
@property(nonatomic , copy)NSString *dispatchprice;
/** 状态 -1取消状态（交易关闭），0 待付款 ，1 买家已付款（待发货），2 卖家已发货（待收货），3 成功（可评价: 等待评价 ; 不可评价 : 交易完成）4 退款申请 */
@property(nonatomic , copy)NSString *status;
/** 评价状态 status 3,4 后允许评价 0 可评价 1 可追加评价 2 已评价 */
@property(nonatomic , copy)NSString *iscomment;
/** 核销 0否 1是 */
@property(nonatomic , copy)NSString *isverify;
/** 用户删除 0否 1是 */
@property(nonatomic , copy)NSString *userdeleted;
/** 退款状态 0 没有退款 1 退款 2 换货 */
@property(nonatomic , copy)NSString *refundstate;
/** 退款申请ID 退款申请处理后清0 */
@property(nonatomic , copy)NSString *refundid;
/** 支付类型 1为余额支付 2在线支付 3 货到付款 11 后台付款 21 微信支付 22 支付宝支付 23 银联支付 */
@property(nonatomic , copy)NSString *paytype;
/** 0 商家配送 1 自提 */
@property(nonatomic , copy)NSString *dispatchtype;
/** 商品数组 */
@property(nonatomic , strong)NSArray *goods;
/** 订单状态 */
@property(nonatomic , copy)NSString *statusstr;
/** 订单商品数量 */
@property(nonatomic , assign)NSInteger goods_num;

@end



@interface MyOrderResultListGoodsModel : NSObject

/** 商品ID */
@property(nonatomic , copy)NSString *goodsid;
/** 购买数量 */
@property(nonatomic , copy)NSString *total;
/** 商品名称 */
@property(nonatomic , copy)NSString *title;
/** 商品缩略图 */
@property(nonatomic , copy)NSString *thumb;
/** 商品价格 */
@property(nonatomic , copy)NSString *price;
/** status */
@property(nonatomic , copy)NSString *status;
/** 商铺名称 */
@property(nonatomic , copy)NSString *merchname;

@end








