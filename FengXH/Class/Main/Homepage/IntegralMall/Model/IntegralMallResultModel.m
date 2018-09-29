//
//  IntegralMallResutlModel.m
//  FengXH
//
//  Created by  on 2018/9/27.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralMallResultModel.h"

@implementation IntegralMallResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"items":[IntegralMallResultItemsModel class]};
}

@end


@implementation IntegralMallResultItemsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"itemsID" : @"id"};
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"items":[IntegralMallResultItemsGoodsModel class]};
}

@end


@implementation IntegralMallResultItemsGoodsModel

@end
