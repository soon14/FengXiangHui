//
//  ConfirmOrderCouponPriceResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfirmOrderCouponPriceResultModel : NSObject

/** isdiscountprice */
@property(nonatomic , copy)NSString *isdiscountprice;
/** discountprice */
@property(nonatomic , copy)NSString *discountprice;
/** 优惠了多少 */
@property(nonatomic , copy)NSString *deductprice;
/** 原价格 */
@property(nonatomic , copy)NSString *coupongoodprice;
/** 优惠形式 */
@property(nonatomic , copy)NSString *coupondeduct_text;
/** 优惠后的价格 */
@property(nonatomic , copy)NSString *totalprice;
/** merchisdiscountprice */
@property(nonatomic , copy)NSString *merchisdiscountprice;
/** couponmerchid */
@property(nonatomic , copy)NSString *couponmerchid;
/** discountprice_array */
@property(nonatomic , strong)NSArray *discountprice_array;
/** goodsarr */
@property(nonatomic , strong)NSArray *goodsarr;

@end


@interface ConfirmOrderCouponPriceResultDiscountPriceArrayModel : NSObject

/** coupongoodprice */
@property(nonatomic , copy)NSString *coupongoodprice;
/** deduct */
@property(nonatomic , copy)NSString *deduct;

@end


@interface ConfirmOrderCouponPriceResultGoodsArrayModel : NSObject

/** cates */
@property(nonatomic , copy)NSString *cates;
/** goodsid */
@property(nonatomic , copy)NSString *goodsid;
/** merchid */
@property(nonatomic , copy)NSString *merchid;
/** marketprice */
@property(nonatomic , copy)NSString *marketprice;
/** total */
@property(nonatomic , copy)NSString *total;
/** optionid */
@property(nonatomic , copy)NSString *optionid;

@end




