//
//  IntegralExchangeResultModel.m
//  FengXH
//
//  Created by  on 2018/9/27.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralExchangeResultModel.h"

@implementation IntegralExchangeResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[IntegralExchangeResultListModel class]};
}

@end


@implementation IntegralExchangeResultMemberModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"memberID" : @"id"};
}

@end


@implementation IntegralExchangeResultListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"listID" : @"id"};
}

@end
