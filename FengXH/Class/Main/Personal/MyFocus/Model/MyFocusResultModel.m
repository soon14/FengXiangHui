//
//  MyFocusResultModel.m
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyFocusResultModel.h"

@implementation MyFocusResultModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[MyFocusResultListModel class]};
}

@end


@implementation MyFocusResultListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"focusID" : @"id"};
}

@end
