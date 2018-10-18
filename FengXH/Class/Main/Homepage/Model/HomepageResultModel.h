//
//  HomepageResultModel.h
//  FengXH
//
//  Created by sun on 2018/10/11.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HomepageResultNoticeModel,HomepageResultGoodsModel,HomepageResultSeckillgroupModel;
@interface HomepageResultModel : NSObject

/** banner */
@property(nonatomic , strong)NSArray *banner;
/** 10个功能区 */
@property(nonatomic , strong)NSArray *menu;
/** 热点轮播 */
@property(nonatomic , strong)HomepageResultNoticeModel *notice;
/** 店主专区等内容 */
@property(nonatomic , strong)NSArray *picturew;
/** 今日秒杀 */
@property(nonatomic , strong)HomepageResultSeckillgroupModel *seckillgroup;
/** 几大商品分区的模型 */
@property(nonatomic , strong)NSArray *goods;
/** 猜你喜欢商品数组 */
@property(nonatomic , strong)HomepageResultGoodsModel *like;

@end




/** 热点轮播的模型 */
@interface HomepageResultNoticeModel : NSObject

/** 热点图片 */
@property(nonatomic , copy)NSString *iconurl;
/** 热点轮播内容数组 */
@property(nonatomic , strong)NSArray *nice;

@end

@interface HomepageResultNoticeNiceModel : NSObject

/** title */
@property(nonatomic , copy)NSString *title;
/** linkurl */
@property(nonatomic , copy)NSString *linkurl;

@end




@interface HomepageResultSeckillgroupModel : NSObject

/** 秒杀图标 */
@property(nonatomic , copy)NSString *iconurl;
/** tag */
@property(nonatomic , copy)NSString *tag;
/** 状态 */
@property(nonatomic , copy)NSString *status;
/** 几点场 */
@property(nonatomic , assign)NSInteger time;
/** 结束时间的时间戳 */
@property(nonatomic , copy)NSString *endtime;
/** 开始时间的时间戳 */
@property(nonatomic , copy)NSString *starttime;
/** 秒杀商品数组 */
@property(nonatomic , strong)NSArray *goods;

@end




/** 存放几大类商品的模型 */
@interface HomepageResultGoodsModel : NSObject

/** 商品大类的图片 */
@property(nonatomic , strong)NSArray *picture;
/** 商品大类的商品 */
@property(nonatomic , strong)NSArray *list;

@end




/** 存放图片的模型 */
@interface HomepageResultPictureModel : NSObject

/** 图片地址 */
@property(nonatomic , copy)NSString *imgurl;
/** 连接 */
@property(nonatomic , copy)NSString *linkurl;
/** 文字描述 */
@property(nonatomic , copy)NSString *text;

@end




/** 存放商品的模型 */
@interface HomepageResultCommodityModel : NSObject

/** 商品图 */
@property(nonatomic , copy)NSString *thumb;
/** 秒杀的价格 */
@property(nonatomic , copy)NSString *price;
/** 现价 */
@property(nonatomic , copy)NSString *marketprice;
/** 原价 */
@property(nonatomic , copy)NSString *productprice;
/** 佣金 */
@property(nonatomic , copy)NSString *commission1;
/** 秒杀百分比 */
@property(nonatomic , copy)NSString *percent;
/** 商品名 */
@property(nonatomic , copy)NSString *title;
/** 商品副标题 */
@property(nonatomic , copy)NSString *subtitle;
/** 商品 id */
@property(nonatomic , copy)NSString *goodsID;
/** 库存 */
@property(nonatomic , assign)NSInteger total;
/** 商品图右上角的小图标 */
@property(nonatomic , copy)NSString *goodsiconsrc;

@end


NS_ASSUME_NONNULL_END
