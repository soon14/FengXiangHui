//
//  PersonalDataModel.m
//  FengXH
//
//  Created by  on 2018/7/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalDataModel.h"

@implementation PersonalDataModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"result":[PersonalDataCollegeModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userID" : @"id"};
}

@end


@implementation PersonalDataCollegeModel

@end


@implementation PersonalDataStaticsModel

@end
