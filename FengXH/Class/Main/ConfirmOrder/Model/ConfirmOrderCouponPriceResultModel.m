//
//  ConfirmOrderCouponPriceResultModel.m
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderCouponPriceResultModel.h"

@implementation ConfirmOrderCouponPriceResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"discountprice_array":[ConfirmOrderCouponPriceResultDiscountPriceArrayModel class],
             @"goodsarr":[ConfirmOrderCouponPriceResultGoodsArrayModel class]
             };
}

@end


@implementation ConfirmOrderCouponPriceResultDiscountPriceArrayModel

@end


@implementation ConfirmOrderCouponPriceResultGoodsArrayModel

@end
