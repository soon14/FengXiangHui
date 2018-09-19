//
//  PushAnimationTools.h
//  PushAnimation_demo
//
//  Created by sun on 2018/8/29.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

typedef enum{
    rippleEffect = 0, //波纹效果
    cube,//立体翻转效果
    suckEffect,//像被吸入瓶子的效果
    oglflip,//翻转
    pageCurl,//翻页效果
    pageUnCurl,//反翻页效果
    cameraIrisHollowOpen,//开镜头效果
    cameraIrisHollowClose,//关镜头效果
    fade,//淡入淡出
    push,//推进效果
    reveal,//揭开效果
    moveIn,//慢慢进入并覆盖效果
    fromBottom,//下翻页效果
    fromTop,//上翻页效果
    fromLeft,//左翻转效果
    fromRight//右翻转效果
} PushControllerAnimation;

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PushAnimationTools : NSObject

+ (CATransition *)pushAnimationWith:(PushControllerAnimation)animation fromController:(id)delegate;

@end
