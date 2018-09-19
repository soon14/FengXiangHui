//
//  GoodsDetailResultModel.m
//  FengXH
//
//  Created by sun on 2018/9/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailResultModel.h"

@implementation GoodsDetailResultModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodsID" : @"id",
             @"share_description" : @"description",
             };
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"options" : [GoodsDetailResultOptionsModel class]};
}

@end


@implementation GoodsDetailResultTagModel

@end



@implementation GoodsDetailResultJDGoodsModel

@end


@implementation GoodsDetailResultMember_levelModel

@end


@implementation GoodsDetailResultDiscountsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"discountsDefault" : @"default"};
}

@end


@implementation GoodsDetailResultShopdetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"shopDescription" : @"description"};
}

@end


@implementation GoodsDetailResultOptionsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"optionsID" : @"id",
             @"titleStr" : @"title"};
}

@end


@implementation GoodsDetailResultSeckillinfoModel

@end




