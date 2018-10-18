//
//  SignInDetailResultModel.m
//  FengXH
//
//  Created by sun on 2018/10/8.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "SignInDetailResultModel.h"

@implementation SignInDetailResultModel


+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[SignInDetailResultListModel class]};
}

@end



@implementation SignInDetailResultTextsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"haveSigned" : @"signed"};
}

@end



@implementation SignInDetailResultListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"listID" : @"id"};
}

@end
