//
//  SpellOrderDetailModel.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderDetailModel.h"

@implementation SpellOrderDetailModel

@end

@implementation SpellOrderDetailAddressModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"addressId" : @"id"};
}

@end


@implementation SpellOrderDetailGoodsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodsId" : @"id"};
}

@end
