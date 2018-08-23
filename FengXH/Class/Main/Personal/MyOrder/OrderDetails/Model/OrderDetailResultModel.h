//
//  OrderDetailResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderDetailResultAddressModel,OrderDetailResultGoodsDiyformdataModel;

@interface OrderDetailResultModel : NSObject

/** 状态 -1取消状态（交易关闭），0 待付款 ，1 买家已付款（待发货），2 卖家已发货（待收货），3 成功（可评价: 等待评价 ; 不可评价 : 交易完成）4 退款申请  */
@property(nonatomic , copy)NSString *status1;
/** status */
@property(nonatomic , copy)NSString *status;
/** goodsprice */
@property(nonatomic , copy)NSString *goodsprice;
/** shopname */
@property(nonatomic , copy)NSString *shopname;
/** dispatchprice */
@property(nonatomic , copy)NSString *dispatchprice;
/** isnewstore */
@property(nonatomic , copy)NSString *isnewstore;
/** price */
@property(nonatomic , copy)NSString *price;
/** ordersn */
@property(nonatomic , copy)NSString *ordersn;
/** createtime */
@property(nonatomic , copy)NSString *createtime;
/** deductcredit */
@property(nonatomic , copy)NSString *deductcredit;
/** deductcredit2 */
@property(nonatomic , copy)NSString *deductcredit2;
/** paytime */
@property(nonatomic , copy)NSString *paytime;
/** sendtime */
@property(nonatomic , copy)NSString *sendtime;
/** acctime */
@property(nonatomic , copy)NSString *acctime;
/** 地址 */
@property(nonatomic , strong)OrderDetailResultAddressModel *address;
/** 商品 */
@property(nonatomic , strong)NSArray *goods;
/** 退换货状态 */
@property(nonatomic , copy)NSString *refundstate;

@end



@interface OrderDetailResultAddressModel : NSObject

/** id */
@property(nonatomic , copy)NSString *address_id;
/** uniacid */
@property(nonatomic , copy)NSString *uniacid;
/** openid */
@property(nonatomic , copy)NSString *openid;
/** realname */
@property(nonatomic , copy)NSString *realname;
/** mobile */
@property(nonatomic , copy)NSString *mobile;
/** province */
@property(nonatomic , copy)NSString *province;
/** city */
@property(nonatomic , copy)NSString *city;
/** area */
@property(nonatomic , copy)NSString *area;
/** town */
@property(nonatomic , copy)NSString *town;
/** address */
@property(nonatomic , copy)NSString *address;
/** isdefault */
@property(nonatomic , copy)NSString *isdefault;

@end



@interface OrderDetailResultGoodsModel : NSObject

/** goodsid */
@property(nonatomic , copy)NSString *goodsid;
/** price */
@property(nonatomic , copy)NSString *price;
/** title */
@property(nonatomic , copy)NSString *title;
/** merchid */
@property(nonatomic , copy)NSString *merchid;
/** thumb */
@property(nonatomic , copy)NSString *thumb;
/** status */
@property(nonatomic , copy)NSString *status;
/** cannotrefund */
@property(nonatomic , copy)NSString *cannotrefund;
/** total */
@property(nonatomic , copy)NSString *total;
/** credit */
@property(nonatomic , copy)NSString *credit;
/** optionid */
@property(nonatomic , copy)NSString *optionid;
/** optiontitle */
@property(nonatomic , copy)NSString *optiontitle;
/** isverify */
@property(nonatomic , copy)NSString *isverify;
/** storeids */
@property(nonatomic , copy)NSString *storeids;
/** seckill */
@property(nonatomic , copy)NSString *seckill;
/** isfullback */
@property(nonatomic , copy)NSString *isfullback;
/** seckill_taskid */
@property(nonatomic , copy)NSString *seckill_taskid;
/** diyformdata */
@property(nonatomic , strong)OrderDetailResultGoodsDiyformdataModel *diyformdata;

@end


@interface OrderDetailResultGoodsDiyformdataModel : NSObject

/** diyshenfenzhenghao */
@property(nonatomic , copy)NSString *diyshenfenzhenghao;

@end



