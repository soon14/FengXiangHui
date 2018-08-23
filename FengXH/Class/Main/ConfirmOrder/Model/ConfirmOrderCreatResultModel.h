//
//  ConfirmOrderCreatResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ConfirmOrderCreatResultMerchsModel;

@interface ConfirmOrderCreatResultModel : NSObject

/** 商品小计 */
@property(nonatomic , copy)NSString *subtotalprice;
/** 会员优惠 */
@property(nonatomic , copy)NSString *discountprice;
/** 京东运费 */
@property(nonatomic , copy)NSString *jd_freight;
/** 1 地址格式错误 */
@property(nonatomic , copy)NSString *jd_area;
/** 运费 */
@property(nonatomic , copy)NSString *dispatch_price;
/** F币可抵扣 */
@property(nonatomic , copy)NSString *deductcredit2;
/** 可用优惠券数量 */
@property(nonatomic , assign)NSInteger couponcount;
/** isdiscountprice */
@property(nonatomic , copy)NSString *isdiscountprice;
/** 秒杀优惠 */
@property(nonatomic , copy)NSString *seckill_price;
/** 其他商铺的商品的信息 */
@property(nonatomic , strong)ConfirmOrderCreatResultMerchsModel *merchs;
/** 商铺列表 */
@property(nonatomic , strong)NSArray *goods_list;

@end

/** 商铺的信息及商铺内商品 */
@interface ConfirmOrderCreatResultGoodsListModel : NSObject

/** 商铺 id */
@property(nonatomic , copy)NSString *merchid;
/** 商铺名称 */
@property(nonatomic , copy)NSString *shopname;
/** 商品数组 */
@property(nonatomic , strong)NSArray *goods;

@end

/** 商铺内的商品信息 */
@interface ConfirmOrderCreatResultGoodsListGoodsModel : NSObject

/** 商品 id */
@property(nonatomic , copy)NSString *goodsid;
/** 数量 */
@property(nonatomic , copy)NSString *total;
/** 最大购买数量 */
@property(nonatomic , copy)NSString *maxbuy;
/** issendfree */
@property(nonatomic , copy)NSString *issendfree;
/** 商品名称 */
@property(nonatomic , copy)NSString *title;
/** 商品图片 */
@property(nonatomic , copy)NSString *thumb;
/** 商品价格 */
@property(nonatomic , copy)NSString *marketprice;
/** 京东商品 id */
@property(nonatomic , copy)NSString *sku_jdid;
/** 折扣 */
@property(nonatomic , strong)NSArray *discount_s;
/** 1：京东商品   0：不是京东商品 */
@property(nonatomic , assign)BOOL jd_saleState;
/** 京东商品有无货状态 */
@property(nonatomic , copy)NSString *jd_kpl;
/** 规格ID */
@property(nonatomic , copy)NSString *optionid;
/** 所属分类 */
@property(nonatomic , copy)NSString *cates;
/** 商铺 id */
@property(nonatomic , copy)NSString *merchid;

@end



/** 其他商铺的商品的信息 */
@interface ConfirmOrderCreatResultMerchsModel : NSObject

/** 商铺 id */
@property(nonatomic , copy)NSString *merchid;
/** 商品总价 */
@property(nonatomic , copy)NSString *ggprice;
/** 商品的 id 数组 */
@property(nonatomic , strong)NSArray *goods;

@end









