//
//  MyOrderModel.m
//  FengXH
//
//  Created by sun on 2018/7/20.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyOrderResultModel.h"

@implementation MyOrderResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[MyOrderResultListModel class]};
}

@end


@implementation MyOrderResultListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"order_id" : @"id"};
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods":[MyOrderResultListGoodsModel class]};
}

@end


@implementation MyOrderResultListGoodsModel



@end
