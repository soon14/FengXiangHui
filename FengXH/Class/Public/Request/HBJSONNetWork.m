//
//  HBJSONNetWork.m
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HBJSONNetWork.h"

@implementation HBJSONNetWork

+ (instancetype)sharedManager {
    static HBJSONNetWork *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return manager;
}

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    if (self = [super initWithSessionConfiguration:configuration]) {
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (void)requestWithPath:(NSString *)path WithParams:(NSDictionary *)params WithSuccessBlock:(requestSuccessBlock)success WithFailureBlock:(requestFailureBlock)failure {
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:path parameters:params error:nil];
    request.timeoutInterval = 10.f;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            success(responseObject);
        } else {
            failure(error);
        }
    }];
    [task resume];
}


@end
