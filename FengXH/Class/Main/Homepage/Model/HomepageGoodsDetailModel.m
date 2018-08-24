//
//  HomepageGoodsDetailModel.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageGoodsDetailModel.h"

@implementation HomepageGoodsDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodsId" : @"id",@"shareDescription":@"description"};
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"options":[HomepageGoodsOptionsModel class]};
}

@end

@implementation HomepageShopdetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"shopDescription":@"description"};
}

@end


@implementation HomepageGoodsDiscountsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"discountsDefault":@"default"};
}

@end


@implementation HomepageGoodsOptionsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"optionsId":@"id",@"titleStr":@"title"};
}

@end

@implementation HomepageGoodsSeckillModel

@end



