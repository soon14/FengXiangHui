//
//  HBBaseAPI.m
//  SSKSports
//
//  Created by sun on 2018/5/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HBBaseAPI.h"

@implementation HBBaseAPI

//拼接新的接口地址
+(NSString *)appendAPIurl:(NSString *)u {
    NSString *url = [NSString stringWithFormat:@"%@%@",KBasicURL,u];
    return url;
}

@end
