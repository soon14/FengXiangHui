//
//  ConfirmOrderCreatResultModel.m
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderCreatResultModel.h"

@implementation ConfirmOrderCreatResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods_list":[ConfirmOrderCreatResultGoodsListModel class]};
}

@end


@implementation ConfirmOrderCreatResultGoodsListModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods":[ConfirmOrderCreatResultGoodsListGoodsModel class]};
}

@end


@implementation ConfirmOrderCreatResultGoodsListGoodsModel

@end


@implementation ConfirmOrderCreatResultMerchsModel

@end





