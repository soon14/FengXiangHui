//
//  WechatPayManageer.h
//  FengXH
//
//  Created by sun on 2018/9/26.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WechatPayManager : NSObject


#pragma mark 微信支付方法
+ (void)WXPayWithAppid:(NSString *)appid noncestr:(NSString *)noncestr package:(NSString *)package partnerid:(NSString *)partnerid prepayid:(NSString *)prepayid timestamp:(NSString *)timestamp key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
