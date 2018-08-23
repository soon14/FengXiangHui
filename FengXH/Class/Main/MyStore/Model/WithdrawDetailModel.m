//
//  WithdrawDetailModel.m
//  FengXH
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "WithdrawDetailModel.h"

@implementation WithdrawDetailModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[WithdrawDetailDataModel class]};
}

@end


@implementation WithdrawDetailDataModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"withdrawDetailId" : @"id"};
}

@end
