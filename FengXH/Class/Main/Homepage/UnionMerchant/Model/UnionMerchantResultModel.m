//
//  UnionMerchantResultModel.m
//  FengXH
//
//  Created by sun on 2018/10/12.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "UnionMerchantResultModel.h"

@implementation UnionMerchantResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"items":[UnionMerchantResultItemsModel class]};
}

@end



@implementation UnionMerchantResultItemsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"itemsID" : @"id"};
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"items":[UnionMerchantResultItemsItemsModel class]};
}

@end



@implementation UnionMerchantResultItemsItemsModel

@end
