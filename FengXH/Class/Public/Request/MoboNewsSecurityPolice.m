//
//  MoboNewsSecurityPolice.m
//  test
//
//  Created by wangle.ltd on 2018/9/7.
//  Copyright © 2018年 wangle.ltd. All rights reserved.
//

#import "MoboNewsSecurityPolice.h"

@implementation MoboNewsSecurityPolice

- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust forDomain:(NSString *)domain {
    return YES;
}

@end
