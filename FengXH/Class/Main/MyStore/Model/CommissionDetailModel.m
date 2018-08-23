//
//  CommissionDetailModel.m
//  FengXH
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "CommissionDetailModel.h"

@implementation CommissionDetailModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[CommissionDetailListModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"totalcount" : @"total"};
}

@end


@implementation CommissionDetailListModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"order_goods":[CommissionDetailOrderGoodsModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"buyerId" : @"id"};
}

@end



@implementation CommissionDetailBuyerModel

@end


@implementation CommissionDetailOrderGoodsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderGoodsId" : @"id"};
}

@end
