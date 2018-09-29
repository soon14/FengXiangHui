//
//  IntegralGoodsDetailResultModel.h
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralGoodsDetailResultModel : NSObject

/** id */
@property(nonatomic , copy)NSString *goodsID;
/** 商品名 */
@property(nonatomic , copy)NSString *title;
/** 商品图 */
@property(nonatomic , copy)NSString *thumb;
/** 库存 */
@property(nonatomic , assign)NSInteger total;
/** 0商品 1优惠卷 2余额 3红包 */
@property(nonatomic , assign)NSInteger goodstype;
/** 邮费 */
@property(nonatomic , copy)NSString *dispatch;
/** 所需积分 */
@property(nonatomic , assign)NSInteger credit;
/** 换购时需要多少钱 */
@property(nonatomic , copy)NSString *money;
/** 原价 */
@property(nonatomic , copy)NSString *price;
/** 倒计时 */
@property(nonatomic , copy)NSString *timeend;
/** 该商品是否可购买 */
@property(nonatomic , assign)BOOL canbuy;
/** 按钮上显示的内容 */
@property(nonatomic , copy)NSString *buymsg;
/** 商品详情图片 */
@property(nonatomic , strong)NSArray *goodsdetail;
/** 商品x推荐 */
@property(nonatomic , copy)NSArray *goodsrec;


@end


@interface IntegralGoodsDetailResultGoodsRecommendModel : NSObject

/** id */
@property(nonatomic , copy)NSString *goodsID;
/** 商品图 */
@property(nonatomic , copy)NSString *thumb;
/** 商品名 */
@property(nonatomic , copy)NSString *title;
/** 所需积分 */
@property(nonatomic , assign)NSInteger credit;
/** 所需金额 */
@property(nonatomic , copy)NSString *money;
/** mincredit */
@property(nonatomic , copy)NSString *mincredit;
/** minmoney */
@property(nonatomic , copy)NSString *minmoney;

@end

NS_ASSUME_NONNULL_END
