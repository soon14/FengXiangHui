//
//  HBNetWork.m
//  SSKSports
//
//  Created by sun on 2018/5/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HBNetWork.h"
#import "MoboNewsSecurityPolice.h"

@implementation HBNetWork

+ (instancetype)sharedManager {
    static HBNetWork *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc]initWithBaseURL:[NSURL URLWithString:@"http://httpbin.org/"]];
    });
    return manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer.timeoutInterval = 10;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/javascript",@"text/json",@"text/html",@"text/xml", nil];
//        self.securityPolicy.allowInvalidCertificates = YES;
        MoboNewsSecurityPolice *securityPolicy = [MoboNewsSecurityPolice defaultPolicy];
        self.securityPolicy = securityPolicy;
    }
    return self;
}

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(id)params
         WithSuccessBlock:(requestSuccessBlock)success
         WithFailureBlock:(requestFailureBlock)failure {
    switch (method) {
        case GET:{
            [self GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        }
            break;
        case POST:{
            [self POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        }
            break;
            
        default:
            break;
    }
}

//图片上传接口
- (void)requestWithPath:(NSString *)path WithParams:(id)params WithImageName:(NSString *)imageName WithImage:(UIImage *)image WithSuccessBlock:(requestSuccessBlock)success WithFailureBlock:(requestFailureBlock)failure {

    [self POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        if (imageData == nil) {
            imageData = UIImagePNGRepresentation(image);
        }
        [formData appendPartWithFileData:imageData name:imageName fileName:imageName mimeType:@"image/jpg/png/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        //NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);

    }];
}

@end
