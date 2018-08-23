//
//  HBJSONNetWork.h
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AFURLSessionManager.h"

//请求成功回调 block
typedef void (^requestSuccessBlock)(NSDictionary *responseDic);

//请求失败回调 block
typedef void (^requestFailureBlock)(NSError *error);


@interface HBJSONNetWork : AFURLSessionManager

+ (instancetype)sharedManager;

- (void)requestWithPath:(NSString *)path
             WithParams:(NSDictionary *)params
       WithSuccessBlock:(requestSuccessBlock)success
       WithFailureBlock:(requestFailureBlock)failure;

@end
