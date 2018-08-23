//
//  MyFootprintResultModel.m
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyFootprintResultModel.h"

@implementation MyFootprintResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[MyFootprintResultListModel class]};
}

@end



@implementation MyFootprintResultListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"footprintID" : @"id"};
}

@end
