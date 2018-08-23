//
//  AddressResultModel.m
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AddressResultModel.h"

@implementation AddressResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[AddressResultListModel class]};
}

@end


@implementation AddressResultListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"addressID" : @"id"};
}

@end
