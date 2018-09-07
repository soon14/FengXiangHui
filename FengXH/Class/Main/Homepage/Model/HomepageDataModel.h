//
//  HomepageDataModel.h
//  FengXH
//
//  Created by sun on 2018/7/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomepageDataBannerModel,HomepageDataMenuModel,HomepageDataNoticeModel,HomepageDataNoticeDataModel,HomepageDataHotPictureModel,HomepageDataSecondKillDataModel,HomepageDataSecondKillModel,HomepageDataCategorySectionImageModel,HomepageDataCategoryGoodsModel,HomepageDataGuessYouLikeGoodsModel;

@interface HomepageDataModel : NSObject

/** 滚动广告 */
@property(nonatomic , strong)HomepageDataBannerModel *M1471835880921;
/** 10个专区-1 */
@property(nonatomic , strong)HomepageDataMenuModel *M1471835886075;
/** 10个专区-2 */
@property(nonatomic , strong)HomepageDataMenuModel *M1529474107640;
/** 热点 */
@property(nonatomic , strong)HomepageDataNoticeModel *M1482809676486;
/** 热点内容 */
@property(nonatomic , strong)HomepageDataHotPictureModel *M1536286629032;
/** 秒杀倒计时 */
@property(nonatomic , strong)HomepageDataSecondKillModel *M1510122188416;
/** 类目精选section图片 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1512455635232;
/** 爆款推荐大图 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1531878941134;
/** 爆款推荐商品 */
@property(nonatomic , strong)HomepageDataCategoryGoodsModel *M1531879645629;
/** 热门推荐大图 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1531878957675;
/** 热门推荐商品 */
@property(nonatomic , strong)HomepageDataCategoryGoodsModel *M1531879773169;
/** 美食专区大图 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1512455725970;
/** 美食专区商品 */
@property(nonatomic , strong)HomepageDataCategoryGoodsModel *M1516787844386;
/** 爱在护肤大图 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1512455784147;
/** 爱在护肤商品 */
@property(nonatomic , strong)HomepageDataCategoryGoodsModel *M1512373325297;
/** 美时美刻大图 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1512455826986;
/** 美时美刻商品 */
@property(nonatomic , strong)HomepageDataCategoryGoodsModel *M1512373372365;
/** 安家落户大图 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1512455857299;
/** 安家落户商品 */
@property(nonatomic , strong)HomepageDataCategoryGoodsModel *M1487819230395;
/** 咿呀学语大图 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1512455916966;
/** 咿呀学语商品 */
@property(nonatomic , strong)HomepageDataCategoryGoodsModel *M1487818916357;
/** 强身健体大图 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1512455889850;
/** 强身健体商品 */
@property(nonatomic , strong)HomepageDataCategoryGoodsModel *M1512373413982;
/** 猜你喜欢图片 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1530682233521;
/** 猜你喜欢商品 */
@property(nonatomic , strong)HomepageDataGuessYouLikeGoodsModel *M1530682437506;


@end


#pragma mark - 滚动广告
@interface HomepageDataBannerModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end


#pragma mark - 滚动广告data
@interface HomepageDataBannerDataModel : NSObject

/** imgurl */
@property(nonatomic , copy)NSString *imgurl;
/** linkurl */
@property(nonatomic , copy)NSString *linkurl;

@end


#pragma mark - 10个专区
@interface HomepageDataMenuModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end

#pragma mark - 10个专区data
@interface HomepageDataMenuDataModel : NSObject

/** imgurl */
@property(nonatomic , copy)NSString *imgurl;
/** linkurl */
@property(nonatomic , copy)NSString *linkurl;
/** text */
@property(nonatomic , copy)NSString *text;

@end


#pragma mark - 热点
@interface HomepageDataNoticeModel : NSObject

/** data */
@property(nonatomic , strong)HomepageDataNoticeDataModel *data;

@end

@interface HomepageDataNoticeDataModel : NSObject

/** iconurl */
@property(nonatomic , copy)NSString *iconurl;
/** data */
@property(nonatomic , strong)NSArray *data;

@end

@interface HomepageDataNoticeDataDetailsModel : NSObject

/** iconurl */
@property(nonatomic , copy)NSString *title;
/** linkurl */
@property(nonatomic , copy)NSString *linkurl;

@end


#pragma mark - 热点内容
@interface HomepageDataHotPictureModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end


#pragma mark -  section图片
@interface HomepageDataPictureDataModel : NSObject

/** imgurl */
@property(nonatomic , copy)NSString *imgurl;
/** linkurl */
@property(nonatomic , copy)NSString *linkurl;

@end


#pragma mark - 秒杀倒计时
@interface HomepageDataSecondKillModel : NSObject

/** data */
@property(nonatomic , strong)HomepageDataSecondKillDataModel *data;

@end

@interface HomepageDataSecondKillDataModel : NSObject

/** tag */
@property(nonatomic , copy)NSString *tag;
/** status */
@property(nonatomic , copy)NSString *status;
/** time */
@property(nonatomic , copy)NSString *time;
/** endtime */
@property(nonatomic , copy)NSString *endtime;
/** starttime */
@property(nonatomic , copy)NSString *starttime;
/** iconurl */
@property(nonatomic , copy)NSString *iconurl;
/** goods */
@property(nonatomic , strong)NSArray *goods;

@end

@interface HomepageDataSecondKillGoodsModel : NSObject

/** thumb */
@property(nonatomic , copy)NSString *thumb;
/** price */
@property(nonatomic , copy)NSString *price;
/** marketprice */
@property(nonatomic , copy)NSString *marketprice;

@end


#pragma mark - 类目精选图片
@interface HomepageDataCategorySectionImageModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end


#pragma mark - 类目精选
@interface HomepageDataCategoryGoodsModel : NSObject

/** cateid */
@property(nonatomic , copy)NSString *cateid;
/** data */
@property(nonatomic , strong)NSArray *goods_list;

@end


#pragma mark - 类目精选商品
@interface HomepageDataCategoryGoodsDataModel : NSObject

/** id */
@property(nonatomic , copy)NSString *goodsID;
/** title */
@property(nonatomic , copy)NSString *title;
/** subtitle */
@property(nonatomic , copy)NSString *subtitle;
/** thumb */
@property(nonatomic , copy)NSString *thumb;
/** marketprice */
@property(nonatomic , copy)NSString *marketprice;
/** productprice */
@property(nonatomic , copy)NSString *productprice;
/** minprice */
@property(nonatomic , copy)NSString *minprice;
/** maxprice */
@property(nonatomic , copy)NSString *maxprice;
/** isdiscount */
@property(nonatomic , copy)NSString *isdiscount;
/** isdiscount_time */
@property(nonatomic , copy)NSString *isdiscount_time;
/** isdiscount_discounts */
@property(nonatomic , copy)NSString *isdiscount_discounts;
/** sales */
@property(nonatomic , copy)NSString *sales;
/** salesreal */
@property(nonatomic , copy)NSString *salesreal;
/** total */
@property(nonatomic , copy)NSString *total;
/** description */
@property(nonatomic , copy)NSString *goods_description;
/** bargain */
@property(nonatomic , copy)NSString *bargain;
/** type */
@property(nonatomic , copy)NSString *type;
/** ispresell */
@property(nonatomic , copy)NSString *ispresell;
/** hasoption */
@property(nonatomic , copy)NSString *hasoption;
/** sku_jdid */
@property(nonatomic , copy)NSString *sku_jdid;
/** xykj_id */
@property(nonatomic , copy)NSString *xykj_id;

@property(nonatomic , strong)NSArray *optionid;

@end


#pragma mark - 猜你喜欢
@interface HomepageDataGuessYouLikeGoodsModel : NSObject

/** cateid */
@property(nonatomic , copy)NSString *cateid;
/** data */
@property(nonatomic , strong)NSArray *goods_list;

@end


#pragma mark - 猜你喜欢商品
@interface HomepageDataGuessYouLikeGoodsDataModel : NSObject

/** id */
@property(nonatomic , copy)NSString *goodsID;
/** title */
@property(nonatomic , copy)NSString *title;
/** thumb */
@property(nonatomic , copy)NSString *thumb;
/** subtitle */
@property(nonatomic , copy)NSString *subtitle;
/** price */
@property(nonatomic , copy)NSString *marketprice;
/** total */
@property(nonatomic , copy)NSString *total;
/** productprice */
@property(nonatomic , copy)NSString *productprice;
/** goodsiconsrc */
@property(nonatomic , copy)NSString *goodsiconsrc;

@end






