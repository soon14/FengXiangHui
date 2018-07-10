//
//  KeyManager.m
//  SSKSports
//
//  Created by sun on 2018/6/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "KeyManager.h"

@implementation KeyManager

+ (instancetype)getInstance {
    static dispatch_once_t token;
    static KeyManager *manager;
    dispatch_once(&token, ^{
        manager = [[KeyManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        
        
    }
    return self;
}


@end
