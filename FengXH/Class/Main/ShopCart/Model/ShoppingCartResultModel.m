//
//  ShoppingCartModel.m
//  FengXH
//
//  Created by sun on 2018/8/1.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ShoppingCartResultModel.h"

@implementation ShoppingCartResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[ShoppingCartResultListModel class]};
}

@end


@implementation ShoppingCartResultListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cart_id" : @"id"};
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"options":[ShoppingCartResultListOptionsModel class]};
}

@end



@implementation ShoppingCartResultListDispatch_fareModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"dispatch_id" : @"id"};
}

@end


@implementation ShoppingCartResultListOptionsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"options_id" : @"id"};
}

@end


@implementation ShoppingCartResultListDiscountsModel

@end


@implementation ShoppingCartResultListIsdiscount_discountsModel

@end


@implementation ShoppingCartResultListIsdiscount_discountsMerchModel

@end





