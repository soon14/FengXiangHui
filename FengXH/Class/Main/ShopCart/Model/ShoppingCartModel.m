//
//  ShoppingCartModel.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"info":[ShoppingCartStoreModel class]};
}

@end


@implementation ShoppingCartStoreModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods":[ShoppingCartGoodsModel class]};
}

@end



@implementation ShoppingCartGoodsModel



@end
