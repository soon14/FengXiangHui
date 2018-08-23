//
//  MyTeamModel.m
//  FengXH
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyTeamModel.h"

@implementation MyTeamModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[MyTeamDataModel class]};
}

@end


@implementation MyTeamDataModel

@end
