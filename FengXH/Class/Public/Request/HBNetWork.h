//
//  HBNetWork.h
//  SSKSports
//
//  Created by sun on 2018/5/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HBHTTPSessionManager.h"

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

@interface HBNetWork : HBHTTPSessionManager

+ (instancetype)sharedManager;

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary *)params
         WithSuccessBlock:(requestSuccessBlock)success
         WithFailureBlock:(requestFailureBlock)failure;

/**
 上传图片接口(单张)
*/
- (void)requestWithPath:(NSString *)path
             WithParams:(id)params
          WithImageName:(NSString *)imageName
              WithImage:(UIImage *)image
       WithSuccessBlock:(requestSuccessBlock)success
       WithFailureBlock:(requestFailureBlock)failure;
@end
