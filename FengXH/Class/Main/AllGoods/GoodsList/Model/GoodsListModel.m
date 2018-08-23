//
//  GoodsListModel.m
//  FengXH
//
//  Created by sun on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsListModel.h"

@implementation GoodsListModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[GoodsListCommodityModel class]};
}

@end



@implementation GoodsListCommodityModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodsID" : @"id",
             @"goods_description":@"description"
             };
}

@end

