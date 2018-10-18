//
//  UserInfoModel.m
//  FengXH
//
//  Created by sun on 2018/7/23.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userid" : @"id"};
}

@end
