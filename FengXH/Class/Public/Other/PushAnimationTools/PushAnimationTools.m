//
//  PushAnimationTools.m
//  PushAnimation_demo
//
//  Created by sun on 2018/8/29.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PushAnimationTools.h"

@implementation PushAnimationTools

#pragma - mark - 页面跳转动画
+ (CATransition *)pushAnimationWith:(PushControllerAnimation)animation fromController:(id)delegate {
    CATransition * transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    switch (animation) {
        case 0:
            transition.type = @"rippleEffect";
            break;
        case 1:
            transition.type = @"cube";
            break;
        case 2:
            transition.type = @"suckEffect";
            break;
        case 3:
            transition.type = @"oglflip";
            break;
        case 4:
            transition.type = @"pageCurl";
            break;
        case 5:
            transition.type = @"pageUnCurl";
            break;
        case 6:
            transition.type = @"cameraIrisHollowOpen";
            break;
        case 7:
            transition.type = @"cameraIrisHollowClose";
            break;
        case 8:
            transition.type = @"fade";
            break;
        case 9:
            transition.type = @"push";
            break;
        case 10:
            transition.type = @"reveal";
            break;
        case 11:
            transition.type = @"moveIn";
            break;
        case 12:
            transition.type = @"fromBottom";
            break;
        case 13:
            transition.type = @"fromTop";
            break;
        case 14:
            transition.type = @"fromLeft";
            break;
        case 15:
            transition.type = @"fromRight";
            break;
        default:
            break;
    }
    transition.subtype = kCATransitionMoveIn;
    transition.delegate = delegate;
    return transition;
}

@end
