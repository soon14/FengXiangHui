//
//  IntegralRecordResultModel.m
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordResultModel.h"

@implementation IntegralRecordResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[IntegralRecordResultListModel class]};
}

@end



@implementation IntegralRecordResultListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"recordID" : @"id"};
}

@end
