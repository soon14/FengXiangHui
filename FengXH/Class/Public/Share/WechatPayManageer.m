//
//  WechatPayManageer.m
//  FengXH
//
//  Created by sun on 2018/9/26.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "WechatPayManager.h"
#import "WXApi.h"
#import <CommonCrypto/CommonDigest.h>

@implementation WechatPayManager

#pragma mark 微信支付方法
+ (void)WXPayWithAppid:(NSString *)appid noncestr:(NSString *)noncestr package:(NSString *)package partnerid:(NSString *)partnerid prepayid:(NSString *)prepayid timestamp:(NSString *)timestamp key:(NSString *)key {
    
    NSString *signString = [NSString stringWithFormat:@"appid=%@&noncestr=%@&package=%@&partnerid=%@&prepayid=%@&timestamp=%@&key=%@",appid,noncestr,package,partnerid,prepayid,timestamp,key];
    NSString *md5SignString = [WechatPayManager md5:signString];
    
    //需要创建这个支付对象
    PayReq *req   = [[PayReq alloc] init];
    //由用户微信号和AppID组成的唯一标识，用于校验微信用户
    req.openID = appid;
    // 商家id，在注册的时候给的
    req.partnerId = partnerid;
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId  = prepayid;
    // 根据财付通文档填写的数据和签名
    req.package  = package;
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr  = noncestr;
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = timestamp;
    req.timeStamp = stamp.intValue;
    // 这个签名也是后台做的
    req.sign = md5SignString;
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];
}

// MD5加密算法
+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    //加密规则，因为逗比微信没有出微信支付demo，这里加密规则是参照安卓demo来得
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //这里的x是小写则产生的md5也是小写，x是大写则md5是大写，这里只能用大写，逗比微信的大小写验证很逗
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
