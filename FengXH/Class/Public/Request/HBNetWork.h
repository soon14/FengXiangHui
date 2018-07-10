//
//  HBNetWork.h
//  SSKSports
//
//  Created by sun on 2018/5/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AFHTTPSessionManager.h"

//请求成功回调 block
typedef void (^requestSuccessBlock)(NSDictionary *responseDic);

//请求失败回调 block
typedef void (^requestFailureBlock)(NSError *error);

//请求方法 define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;

@interface HBNetWork : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary *)params
         WithSuccessBlock:(requestSuccessBlock)success
         WithFailureBlock:(requestFailureBlock)failure;

@end
