//
//  ShoppingCartModel.h
//  FengXH
//
//  Created by sun on 2018/8/1.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShoppingCartResultListIsdiscount_discountsModel,ShoppingCartResultListIsdiscount_discountsMerchModel,ShoppingCartResultListDiscountsModel,ShoppingCartResultListDispatch_fareModel;

@interface ShoppingCartResultModel : NSObject

/** 全部选中状态 true全选 false不是全选 */
@property(nonatomic , assign)BOOL ischeckall;
/** 结算总数 */
@property(nonatomic , assign)NSInteger total;
/** 结算总价 */
@property(nonatomic , copy)NSString *totalprice;
/** 商品数组 */
@property(nonatomic , strong)NSArray *list;

@end



@interface ShoppingCartResultListModel : NSObject

/** 购物车ID */
@property(nonatomic , copy)NSString *cart_id;
/** 商品数量 */
@property(nonatomic , assign)NSInteger total;
/** 商品ID */
@property(nonatomic , copy)NSString *goodsid;
/** 库存 */
@property(nonatomic , copy)NSString *stock;
/** 预售结束时间 */
@property(nonatomic , copy)NSString *preselltimeend;
/** 预售价格 */
@property(nonatomic , copy)NSString *gpprice;
/** 启用商品规则 0 不启用 1 启用 */
@property(nonatomic , assign)BOOL hasoption;
/** 商品库存 -1 永久可卖 */
@property(nonatomic , copy)NSString *optionstock;
/** 预售价格 */
@property(nonatomic , copy)NSString *presellprice;
/** 是否预售商品 0否 1是 */
@property(nonatomic , assign)BOOL ispresell;
/** 单次最多购买量 0不限 */
@property(nonatomic , assign)NSInteger maxbuy;
/** 商品名称 */
@property(nonatomic , copy)NSString *title;
/** 商品缩略图 */
@property(nonatomic , copy)NSString *thumb;
/** 商品现价 */
@property(nonatomic , copy)NSString *marketprice;
/** 商品原价 */
@property(nonatomic , copy)NSString *productprice;
/** 规格名称 */
@property(nonatomic , copy)NSString *optiontitle;
/** 规格ID */
@property(nonatomic , copy)NSString *optionid;
/** 规格设置 */
@property(nonatomic , copy)NSString *specs;
/** 用户单次必须购买数量 0不限 */
@property(nonatomic , copy)NSString *minbuy;
/** 商品单位 */
@property(nonatomic , copy)NSString *unit;
/** 商户ID */
@property(nonatomic , copy)NSString *merchid;
/** 0 */
@property(nonatomic , copy)NSString *checked;
/** 促销价格 数字为价格 百分数 为折扣 */
@property(nonatomic , strong)ShoppingCartResultListIsdiscount_discountsModel *isdiscount_discounts;
/** 促销 */
@property(nonatomic , copy)NSString *isdiscount;
/** 促销结束时间戳 */
@property(nonatomic , copy)NSString *isdiscount_time;
/** isnodiscount */
@property(nonatomic , copy)NSString *isnodiscount;
/** 折扣 */
@property(nonatomic , strong)ShoppingCartResultListDiscountsModel *discounts;
/** 手机端使用的价格 0 当前设置促销价格 1 商户设置促销价格 */
@property(nonatomic , copy)NSString *merchsale;
/** 是否选中 0否 1是 */
@property(nonatomic , assign)BOOL selected;
/** 类型 1 实体物品 2 虚拟物品 3 虚拟物品(卡密) 4 批发 10 话费流量充值 20 充值卡 */
@property(nonatomic , copy)NSString *type;
/** intervalfloor */
@property(nonatomic , copy)NSString *intervalfloor;
/** intervalprice */
@property(nonatomic , copy)NSString *intervalprice;
/** isverify */
@property(nonatomic , copy)NSString *isverify;
/** dispatchtype */
@property(nonatomic , copy)NSString *dispatchtype;
/** 运费 */
@property(nonatomic , copy)NSString *dispatchprice;
/** dispatchid */
@property(nonatomic , copy)NSString *dispatchid;
/** 没打折原价 */
@property(nonatomic , copy)NSString *markeproduct;
/** ggprice */
@property(nonatomic , copy)NSString *ggprice;
/** discounttype */
@property(nonatomic , copy)NSString *discounttype;
/** 最多购买数量 */
@property(nonatomic , copy)NSString *totalmaxbuy;
/** merchname */
@property(nonatomic , copy)NSString *merchname;
/** 运费模板 */
@property(nonatomic , strong)ShoppingCartResultListDispatch_fareModel *dispatch_fare;
/** options */
@property(nonatomic , strong)NSArray *options;
/** 折扣 */
@property(nonatomic , strong)NSArray *discount_s;

@end


/** 运费模板 */
@interface ShoppingCartResultListDispatch_fareModel : NSObject

/** 运费id */
@property(nonatomic , copy)NSString *dispatch_id;
/** 运费模板名 */
@property(nonatomic , copy)NSString *dispatachname;
/** 首运费价格 */
@property(nonatomic , copy)NSString *firstprice;
/** 续重/续件 */
@property(nonatomic , copy)NSString *secondprice;
/** 首重 */
@property(nonatomic , copy)NSString *firstweight;
/** 指定物流 */
@property(nonatomic , copy)NSString *express;
/** 城市 */
@property(nonatomic , copy)NSString *areas;
/** 满多少包邮 */
@property(nonatomic , copy)NSString *freeprice;

@end


@interface ShoppingCartResultListOptionsModel : NSObject

/** options_id */
@property(nonatomic , copy)NSString *options_id;
/** uniacid */
@property(nonatomic , copy)NSString *uniacid;
/** 商品id */
@property(nonatomic , copy)NSString *goodsid;
/** 名称 */
@property(nonatomic , copy)NSString *title;
/** productprice */
@property(nonatomic , copy)NSString *productprice;
/** marketprice */
@property(nonatomic , copy)NSString *marketprice;
/** costprice */
@property(nonatomic , copy)NSString *costprice;
/** 商品库存 */
@property(nonatomic , copy)NSString *stock;
/** weight */
@property(nonatomic , copy)NSString *weight;
/** 规格设置 */
@property(nonatomic , copy)NSString *specs;
/** 商品编码 */
@property(nonatomic , copy)NSString *goodssn;
/** 商品条码 */
@property(nonatomic , copy)NSString *productsn;
/** 图片 */
@property(nonatomic , copy)NSString *thumb;

@end


@interface ShoppingCartResultListDiscountsModel : NSObject

/** type */
@property(nonatomic , copy)NSString *type;
/** level6 */
@property(nonatomic , copy)NSString *level6;
/** level6_pay */
@property(nonatomic , copy)NSString *level6_pay;

@end

@interface ShoppingCartResultListIsdiscount_discountsModel : NSObject

/** type */
@property(nonatomic , copy)NSString *type;
/** merch */
@property(nonatomic , strong)ShoppingCartResultListIsdiscount_discountsMerchModel *merch;

@end


@interface ShoppingCartResultListIsdiscount_discountsMerchModel : NSObject

/** option0 */
@property(nonatomic , copy)NSString *option0;

@end



