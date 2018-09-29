//
//  IntegralGoodsDetailResultModel.m
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralGoodsDetailResultModel.h"

@implementation IntegralGoodsDetailResultModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodsID" : @"id"};
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goodsrec" : [IntegralGoodsDetailResultGoodsRecommendModel class]};
}

@end


@implementation IntegralGoodsDetailResultGoodsRecommendModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodsID" : @"id"};
}

@end
