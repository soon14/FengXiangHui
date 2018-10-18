//
//  SignInResultModel.m
//  FengXH
//
//  Created by sun on 2018/10/9.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "SignInResultModel.h"

@implementation SignInResultModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"haveSigned" : @"signed"};
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"calendar":[SignInResultCalendarModel class]};
}

@end



@implementation SignInResultMemberModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"memberID" : @"id"};
}

@end



@implementation SignInResultCalendarModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"haveSigned" : @"signed"};
}

@end



@implementation SignInResultAdvawardModel

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"order":[SignInResultAdvawardOrderModel class]};
}

@end



@implementation SignInResultAdvawardOrderModel



@end
