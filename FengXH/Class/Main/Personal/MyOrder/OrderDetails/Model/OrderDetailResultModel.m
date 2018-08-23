//
//  OrderDetailResultModel.m
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderDetailResultModel.h"

@implementation OrderDetailResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods":[OrderDetailResultGoodsModel class]};
}

@end


@implementation OrderDetailResultAddressModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"address_id" : @"id"};
}

@end


@implementation OrderDetailResultGoodsModel


@end



@implementation OrderDetailResultGoodsDiyformdataModel


@end

