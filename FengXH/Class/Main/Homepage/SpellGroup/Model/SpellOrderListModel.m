//
//  SpellOrderListModel.m
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderListModel.h"

@implementation SpellOrderListModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[SpellOrderListDataModel class]};
}

@end


@implementation SpellOrderListDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderId" : @"id"};
}

@end
