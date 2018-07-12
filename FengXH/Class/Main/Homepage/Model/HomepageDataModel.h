//
//  HomepageDataModel.h
//  FengXH
//
//  Created by sun on 2018/7/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomepageDataBannerModel,HomepageDataMenuFirstModel,HomepageDataMenuSecondModel,HomepageDataNoticeModel,HomepageDataNoticeDataModel,HomepageDataHotPictureModel,HomepageDataSecondKillDataModel,HomepageDataSecondKillModel,HomepageDataCategorySectionImageModel,HomepageDataFirstCategoryImageModel,HomepageDataFirstCategoryGoodsModel,HomepageDataSecondCategoryImageModel,HomepageDataSecondCategoryGoodsModel,HomepageDataThirdCategoryImageModel,HomepageDataThirdCategoryGoodsModel,HomepageDataFourthCategoryImageModel,HomepageDataFourthCategoryGoodsModel,HomepageDataFifthCategoryImageModel,HomepageDataFifthCategoryGoodsModel,HomepageDataSixthCategoryImageModel,HomepageDataSixthCategoryGoodsModel,HomepageDataGuessYouLikeImageModel,HomepageDataGuessYouLikeGoodsModel;

@interface HomepageDataModel : NSObject

/** 滚动广告 */
@property(nonatomic , strong)HomepageDataBannerModel *M1471835880921;
/** 10个专区-1 */
@property(nonatomic , strong)HomepageDataMenuFirstModel *M1471835886075;
/** 10个专区-2 */
@property(nonatomic , strong)HomepageDataMenuSecondModel *M1529474107640;
/** 热点 */
@property(nonatomic , strong)HomepageDataNoticeModel *M1482809676486;
/** 热点内容 */
@property(nonatomic , strong)HomepageDataHotPictureModel *M1528772177656;
/** 秒杀倒计时 */
@property(nonatomic , strong)HomepageDataSecondKillModel *M1510122188416;
/** 类目精选section图片 */
@property(nonatomic , strong)HomepageDataCategorySectionImageModel *M1512455635232;
/** 吃货联盟大图 */
@property(nonatomic , strong)HomepageDataFirstCategoryImageModel *M1512455725970;
/** 吃货联盟商品 */
@property(nonatomic , strong)HomepageDataFirstCategoryGoodsModel *M1516787844386;
/** 爱在护肤大图 */
@property(nonatomic , strong)HomepageDataSecondCategoryImageModel *M1512455784147;
/** 爱在护肤商品 */
@property(nonatomic , strong)HomepageDataSecondCategoryGoodsModel *M1512373325297;
/** 美时美刻大图 */
@property(nonatomic , strong)HomepageDataThirdCategoryImageModel *M1512455826986;
/** 美时美刻商品 */
@property(nonatomic , strong)HomepageDataThirdCategoryGoodsModel *M1512373372365;
/** 安家落户大图 */
@property(nonatomic , strong)HomepageDataFourthCategoryImageModel *M1512455857299;
/** 安家落户商品 */
@property(nonatomic , strong)HomepageDataFourthCategoryGoodsModel *M1487819230395;
/** 咿呀学语大图 */
@property(nonatomic , strong)HomepageDataFifthCategoryImageModel *M1512455916966;
/** 咿呀学语商品 */
@property(nonatomic , strong)HomepageDataFifthCategoryGoodsModel *M1487818916357;
/** 强身健体大图 */
@property(nonatomic , strong)HomepageDataSixthCategoryImageModel *M1512455889850;
/** 强身健体商品 */
@property(nonatomic , strong)HomepageDataSixthCategoryGoodsModel *M1512373413982;
/** 猜你喜欢图片 */
@property(nonatomic , strong)HomepageDataGuessYouLikeImageModel *M1530682233521;
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


#pragma mark - 10个专区-1
@interface HomepageDataMenuFirstModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end

#pragma mark - 10个专区-1
@interface HomepageDataMenuSecondModel : NSObject

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


#pragma mark - 吃货联盟大图
@interface HomepageDataFirstCategoryImageModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end


#pragma mark - 爱在护肤大图
@interface HomepageDataSecondCategoryImageModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end

#pragma mark - 美时美刻大图
@interface HomepageDataThirdCategoryImageModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end

#pragma mark - 安家落户大图
@interface HomepageDataFourthCategoryImageModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end

#pragma mark - 咿呀学语大图
@interface HomepageDataFifthCategoryImageModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end

#pragma mark - 强身健体大图
@interface HomepageDataSixthCategoryImageModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end


#pragma mark - 吃货联盟商品
@interface HomepageDataFirstCategoryGoodsModel : NSObject

/** cateid */
@property(nonatomic , copy)NSString *cateid;
/** data */
@property(nonatomic , strong)NSArray *goods_list;

@end


#pragma mark - 爱在护肤商品
@interface HomepageDataSecondCategoryGoodsModel : NSObject

/** cateid */
@property(nonatomic , copy)NSString *cateid;
/** data */
@property(nonatomic , strong)NSArray *goods_list;

@end


#pragma mark - 美时美刻商品
@interface HomepageDataThirdCategoryGoodsModel : NSObject

/** cateid */
@property(nonatomic , copy)NSString *cateid;
/** data */
@property(nonatomic , strong)NSArray *goods_list;

@end


#pragma mark - 安家落户商品
@interface HomepageDataFourthCategoryGoodsModel : NSObject

/** cateid */
@property(nonatomic , copy)NSString *cateid;
/** data */
@property(nonatomic , strong)NSArray *goods_list;

@end


#pragma mark - 咿呀学语商品
@interface HomepageDataFifthCategoryGoodsModel : NSObject

/** cateid */
@property(nonatomic , copy)NSString *cateid;
/** data */
@property(nonatomic , strong)NSArray *goods_list;

@end


#pragma mark - 强身健体商品
@interface HomepageDataSixthCategoryGoodsModel : NSObject

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

@end


#pragma mark - 强身健体大图
@interface HomepageDataGuessYouLikeImageModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

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






