//
//  GoodsDetailResultModel.h
//  FengXH
//
//  Created by sun on 2018/9/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsDetailResultJDGoodsModel,GoodsDetailResultMember_levelModel,GoodsDetailResultDiscountsModel,GoodsDetailResultShopdetailModel,GoodsDetailResultSeckillinfoModel,GoodsDetailResultTagModel;

@interface GoodsDetailResultModel : NSObject

/** 商品 id */
@property(nonatomic , copy)NSString *goodsID;
/** 类型 1 实体物品 2 虚拟物品 3 虚拟物品(卡密) 4 批发 10 话费流量充值 20 充值卡 暂只支持1实体物品 */
@property(nonatomic , assign)NSInteger type;
/** 商品名称 */
@property(nonatomic , copy)NSString *title;
/** 商品缩略图 */
@property(nonatomic , copy)NSString *thumb;
/** 商品单位 */
@property(nonatomic , copy)NSString *unit;
/** 二维码分享图 */
@property(nonatomic , copy)NSString *share_image;
/** 分享 URL */
@property(nonatomic , copy)NSString *share_url;
/** 分享描述 */
@property(nonatomic , copy)NSString *share_description;
/** 商品详情，图片地址 */
@property(nonatomic , strong)NSArray *content;
/** 子标题 */
@property(nonatomic , copy)NSString *subtitle;
/** 商品所在省 如为空则显示商城所在 */
@property(nonatomic , copy)NSString *province;
/** 商品所在城市 如为空则显示商城所在 */
@property(nonatomic , copy)NSString *city;
/** 商品编号：海带网 */
@property(nonatomic , copy)NSString *goodssn;
/** 商品条码 */
@property(nonatomic , copy)NSString *productsn;
/** 商品原价 */
@property(nonatomic , copy)NSString *productprice;
/** 商品现价 */
@property(nonatomic , copy)NSString *marketprice;
/** 商品成本价 */
@property(nonatomic , copy)NSString *costprice;
/** 商品库存 */
@property(nonatomic , copy)NSString *total;
/** 已出售数 */
@property(nonatomic , assign)NSInteger sales;
/** 单次最多购买量 */
@property(nonatomic , assign)NSInteger maxbuy;
/** 用户最多购买量 */
@property(nonatomic , assign)NSInteger usermaxbuy;
/** 运费 */
@property(nonatomic , copy)NSString *dispatchprice;
/** 缩略图地址 */
@property(nonatomic , strong)NSArray *thumb_url;
/** 选择商品规格 */
@property(nonatomic , strong)NSArray *options;
/** 可以加入购物车 */
@property(nonatomic , assign)BOOL canAddCart;
/** 启用商品规则 0 不启用 1 启用 */
@property(nonatomic , assign)BOOL hasoption;
/** 关注 */
@property(nonatomic , assign)BOOL isFavorite;
/** 提供发票 */
@property(nonatomic , assign)BOOL invoice;
/** 查看次数 */
@property(nonatomic , assign)NSInteger viewcount;
/**  京东商品 id */
@property(nonatomic , assign)NSInteger sku_jdid;
/** 质量保证等信息 */
@property(nonatomic , strong)GoodsDetailResultTagModel *tag;
/** 京东商品实时运费 */
@property(nonatomic , strong)GoodsDetailResultJDGoodsModel *jdgoods;
/** 会员、店主可享受 */
@property(nonatomic , strong)GoodsDetailResultMember_levelModel *member_level;
/** 折扣 */
@property(nonatomic , strong)GoodsDetailResultDiscountsModel *discounts;
/** 店铺详情 */
@property(nonatomic , strong)GoodsDetailResultShopdetailModel *shopdetail;
/** 秒杀 */
@property(nonatomic , strong)GoodsDetailResultSeckillinfoModel *seckillinfo;


@end



/** 质量保证等信息 */
@interface GoodsDetailResultTagModel : NSObject

/** 正品保证等 */
@property(nonatomic , strong)NSArray *quality;

@end


/** 京东商品运费 */
@interface GoodsDetailResultJDGoodsModel : NSObject

/** 运费 */
@property(nonatomic , copy)NSString *jd_freight;
/** 有货/无货 */
@property(nonatomic , copy)NSString *kpl;

@end

/** 活动店主优惠 */
@interface GoodsDetailResultMember_levelModel : NSObject

/** 可享受优惠的用户等级 */
@property(nonatomic , copy)NSString *level;
/** 可享受的优惠价格 */
@property(nonatomic , copy)NSString *memberprice;

@end

/** 活动折扣信息 */
@interface GoodsDetailResultDiscountsModel : NSObject

/** type */
@property(nonatomic , copy)NSString *type;
/** 折扣打几折 */
@property(nonatomic , copy)NSString *discountsDefault;
/** default_pay */
@property(nonatomic , copy)NSString *default_pay;

@end


/** 店铺信息 */
@interface GoodsDetailResultShopdetailModel : NSObject

/** 按钮1 有值就显示，没有就显示 查看所有商品*/
@property(nonatomic , copy)NSString *btntext1;
/** 按钮1 跳转链接 */
@property(nonatomic , copy)NSString *btnurl1;
/** 按钮2 有值就显示，没有就显示 进店逛逛 */
@property(nonatomic , copy)NSString *btntext2;
/** 按钮2 跳转链接 店铺地址 */
@property(nonatomic , copy)NSString *btnurl2;
//店铺描述
@property(nonatomic , copy)NSString *shopDescription;
//头像
@property(nonatomic , copy)NSString *logo;
//名字
@property(nonatomic , copy)NSString *shopname;

@end


/** 商品规格等详细信息 */
@interface GoodsDetailResultOptionsModel : NSObject

/** 价钱 */
@property(nonatomic , copy)NSString *marketprice;
/** 商品原价 */
@property(nonatomic , copy)NSString *productprice;
/** title */
@property(nonatomic , copy)NSString *title;
/** 缩略图 */
@property(nonatomic , copy)NSString *thumb;
/** 商品 id */
@property(nonatomic , copy)NSString *goodsid;
/** 商品编码 */
@property(nonatomic , copy)NSString *goodssn;
/** id */
@property(nonatomic , copy)NSString *optionsID;
/** 商品条码 */
@property(nonatomic , copy)NSString *productsn;
/** 规格设置 */
@property(nonatomic , copy)NSString *specs;
/** 商品库存 */
@property(nonatomic , copy)NSString *stock;
/** uniacid */
@property(nonatomic , copy)NSString *uniacid;

@end


/** 秒杀商品 */
@interface GoodsDetailResultSeckillinfoModel : NSObject

/** 开始时间 */
@property(nonatomic , copy)NSString *starttime;
/** 结束时间 */
@property(nonatomic , copy)NSString *endtime;
/** 现价 */
@property(nonatomic , copy)NSString *price;
/** 原价 */
@property(nonatomic , copy)NSString *oldprice;
/** status */
@property(nonatomic , copy)NSString *status;
/** 已出售 % */
@property(nonatomic , copy)NSString *percent;
/** tag */
@property(nonatomic , copy)NSString *tag;
/** 整点 */
@property(nonatomic , copy)NSString *time;

@end





