//
//  ConfirmOrderCouponResultModel.m
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderCouponResultModel.h"

@implementation ConfirmOrderCouponResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[ConfirmOrderCouponResultListModel class]};
}

@end



@implementation ConfirmOrderCouponResultListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"couponID" : @"id"};
}

@end
