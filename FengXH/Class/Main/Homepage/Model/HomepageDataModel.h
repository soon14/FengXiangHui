//
//  HomepageDataModel.h
//  FengXH
//
//  Created by sun on 2018/7/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomepageDataBannerModel,HomepageDataMenuFirstModel,HomepageDataMenuSecondModel,HomepageDataNoticeModel,HomepageDataNoticeDataModel,HomepageDataPicturewModel,HomepageDataSecondKillDataModel,HomepageDataSecondKillModel,HomepageDataCategoryModel;

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
@property(nonatomic , strong)HomepageDataPicturewModel *M1528772177656;
/** 秒杀倒计时 */
@property(nonatomic , strong)HomepageDataSecondKillModel *M1510122188416;
/** 类目精选图片 */
@property(nonatomic , strong)HomepageDataCategoryModel *M1512455635232;

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
@interface HomepageDataPicturewModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end

@interface HomepageDataPicturewDataModel : NSObject

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
@interface HomepageDataCategoryModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end

@interface HomepageDataCategoryDataModel : NSObject

/** imgurl */
@property(nonatomic , copy)NSString *imgurl;
/** linkurl */
@property(nonatomic , copy)NSString *linkurl;

@end











