//
//  PrefixHeader.h
//  SSKSports
//
//  Created by sun on 2018/5/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h


#endif /* PrefixHeader_h */

#import "AFNetworking.h"
#import "ShareManager.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "HBBaseAPI.h"
#import "DBHUD.h"
#import "HBNetWork.h"
#import "Masonry.h"
#import "YYModel.h"
#import "CustomActionSheet.h"
#import "JHSysAlertUtil.h"
#import "SDAutoLayout.h"
#import "KeyManager.h"
#import "YYWebImage.h"
#import "DateTools.h"


//测试
#define KBasicURL @"http://vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&"



#define KUserToken @"userToken"
#define KNickName @"nickName"
#define KSignName @"signName"
#define KHeadId @"headId"
#define KIsPush @"isPush"
#define KNotLoggedInCode @"400"
#define KPageSize 10
#define KNetworkError @"网络连接错误"
#define KRequestError @"访问出错啦，请稍后再试~"

// 日志级别
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s\n", [[NSString stringWithFormat:FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...)
#endif

#define KMAINSIZE [UIScreen mainScreen].bounds.size
#define KScreenRatio [UIScreen mainScreen].bounds.size.width/375
#define KUIColorFromHex(s)  [UIColor colorWithRed:(((s &0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define KGreenColor KUIColorFromHex(0x45ba3c)
#define KRedColor KUIColorFromHex(0xdd5b55)
#define KAppDefaultColor KUIColorFromHex(0xff3529)
#define KLineColor KUIColorFromHex(0xeeeeee)
#define KTableBackgroundColor KUIColorFromHex(0xf0f3f3)
#define KFont(s)     [UIFont systemFontOfSize:s]


/**
 iPhone X 机型
 */
#define KDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/**
  导航栏高度
 */
#define KNaviHeight (KDevice_Is_iPhoneX ? 88 : 64)
/**
 标签栏高度
 */
#define KTabbarHeight (KDevice_Is_iPhoneX ? 83 : 49)
/**
 适配 iPhone X 的屏幕底部高度
 */
#define KBottomHeight (KDevice_Is_iPhoneX ? 34 : 0)


// 个人中心全部订单类型
typedef NS_ENUM(NSInteger , PersonalOrderType) {
    /** 全部订单 */
    AllOrder = 0 ,
    /** 待支付订单 */
    waitingForPayOrder ,
    /** 待发货订单 */
    waitingForSendOrder ,
    /** 待收货订单 */
    waitingForReceiveOrder ,
    /** 已完成订单 */
    completedOrder ,
};





