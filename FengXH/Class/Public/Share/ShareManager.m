//
//  ShareManager.m
//  SSKSports
//
//  Created by sun on 2018/6/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//


#import "ShareManager.h"
#import "UserInfoModel.h"
#import "HomepageDataModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@implementation ShareManager

#pragma mark - 将用户信息存入本地
+ (void)saveUserInfo:(UserInfoModel *)infoModel {
    [[NSUserDefaults standardUserDefaults] setObject:infoModel.token forKey:KUserToken];
    [[NSUserDefaults standardUserDefaults] setObject:infoModel.userid forKey:KUserId];
    [[NSUserDefaults standardUserDefaults] setObject:infoModel.mobile forKey:KUserMobile];
    [[NSUserDefaults standardUserDefaults] setObject:infoModel.openid forKey:KOpenid];
    [[NSUserDefaults standardUserDefaults] setObject:infoModel.salt forKey:KSalt];
}

#pragma mark - 清除用户信息
+ (void)clearUserInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUserToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUserId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUserMobile];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KOpenid];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KSalt];
}

#pragma mark - 获取当前时间戳有两种方法(以秒为单位)
+ (NSString *)getNowTimeTimestamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

#pragma mark - 判断是否为纯数字
+ (BOOL)isPureInt:(NSString *)string {
    NSScanner * scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (NSInteger)getHomePageFunctionJumpTypeWithMenuDataModel:(HomepageDataMenuDataModel *)menuModel {
    if ([ShareManager isPureInt:menuModel.linkurl]) {
        //  纯数字，跳转至全部商品页
        return FunctionJumpAllGoods;
    } else if ([menuModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=seckill"]) {
        //  今日秒杀
        return FunctionJumpSecondKill;
    } else if ([menuModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=groups"]) {
        //  拼团福利
        return FunctionJumpSpellGroup;
    } else if ([menuModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=hlapi.conversation.dial"]) {
        //  云电话
        return FunctionJumpCloudPhone;
    } else if ([menuModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=article.list"]) {
        //赏金文章
        return FunctionJumpArticleList;
    } else if ([menuModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=196"]) {
        //联盟商户
        return FunctionJumpBusiness;
    } else if ([menuModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=sign"]) {
        //签到领奖
        return FunctionJumpSignIn;
    } else if ([menuModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=sns.newv2&id=29"]) {
        //分享圈子
        return FunctionJumpShareCircle;
    } else if ([menuModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=29"]) {
        //积分兑换
        return IntegralExchange;
    } else {
        //  跳转网页
        return FunctionJumpWebView;
    }
}

#pragma mark - 传入 HomepageDataBannerDataModel 判断跳转至啥地方
+ (NSInteger)getHomePageBannerJumpTypeWithBannerDataModel:(HomepageDataBannerDataModel *)bannerModel {
    if ([bannerModel.linkurl containsString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=goods.detail&id="]) {
        //商品详情
        return BannerJumpGoodsDetails;
    } else if ([bannerModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=groups"]) {
        //拼团福利
        return BannerJumpSpellGroup;
    } else if ([bannerModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=254"] || [bannerModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=305"]) {
        //生鲜超市
        return BannerJumpFreshSupermarket;
    } else if ([bannerModel.linkurl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=139"]) {
        //京东优选
        return BannerJumpJingDongOptimization;
    }
    //网页
    return BannerJumpWebView;
}

#pragma mark - 全部商品二级分类的头视图 —— 传入 URLString 判断跳转至啥地方
+ (NSInteger)getAllGoodsCollectionHeaderJumpTypeWithLinkUrl:(NSString *)linkUrl {
    if ([linkUrl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=153"]) {
        return AllGoodsCollectionHeaderJumpJingDongOptimization;
    } else if ([linkUrl containsString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=goods.detail&id="]) {
        return AllGoodsCollectionHeaderJumpGoodsDetails;
    } else if ([linkUrl containsString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=merch&merchid="] || [linkUrl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=quick&id=3&merchid=136"] || [linkUrl isEqualToString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=merch&merchid=131&wxref=mp.weixin.qq.com#wechat_redirect"]) {
        return AllGoodsCollectionHeaderJumpSafari;
    }
    return AllGoodsCollectionHeaderJumpNone;
}

#pragma mark - 宽度固定为屏幕宽度，获取图片高度
+ (CGFloat)getImageHeight:(NSString *)imageName {
    return (KMAINSIZE.width/CGImageGetWidth([UIImage imageNamed:imageName].CGImage))*CGImageGetHeight([UIImage imageNamed:imageName].CGImage);
}

#pragma mark - 将dic 转成字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
#pragma mark - 分享
+ (void)shareWithTitle:(NSString *)titleStr andMessage:(NSString *)message andUrl:(NSString *)urlStr andImg:(NSArray *)imgArr {
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    [shareParams SSDKSetupShareParamsByText:message images:imgArr url:[NSURL URLWithString:urlStr] title:titleStr type:SSDKContentTypeAuto];
    
    //有的平台要客户端分享需要加此方法，例如微博
    [shareParams SSDKEnableUseClientShare];
    
    [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                [JHSysAlertUtil presentAlertViewWithTitle:@"分享成功" message:nil confirmTitle:@"确定" handler:nil];
                break;
            }
            case SSDKResponseStateFail:
            {
                [JHSysAlertUtil presentAlertViewWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] confirmTitle:@"OK" handler:nil];
                break;
            }
            default:
                break;
        }
    }];
}

#pragma mark - 判断是否为数字（含小数）
+ (BOOL)isNumber:(NSString *)strValue {
    if (strValue == nil || [strValue length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![strValue isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}




@end
