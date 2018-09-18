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
#import "MJExtension.h"
#import "HBJSONNetWork.h"
#import "PhotoHelper.h"
#import "UITextView+Placeholder.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
#import "MLEmojiLabel.h"
#import "QMDateManager.h"
#import "BaseCornerShadowView.h"


//客服模块的宏定义
#define kInputViewHeight 50

//正式
//#define KBasicURL @"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&"

//测试
#define KBasicURL @"http://dev.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&"



#define KUserToken @"userToken"
#define KUserMobile @"userMobile"
#define KOpenid @"openid"
#define KUserId @"userid"
#define KSalt @"salt"
#define KNotLoggedInCode @"400"
#define KPageSize 10
#define KNetworkError @"网络连接错误"
#define KRequestError @"访问出错啦，请稍后再试~"


// 日志级别
#ifdef DEBUG
#define NSLog(FORMAT, ...) printf("[ %s:(%d) ] %s :%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(FORMAT), ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...)
#endif

#define KMAINSIZE [UIScreen mainScreen].bounds.size
#define KScreenRatio [UIScreen mainScreen].bounds.size.width/375

#define KUIColorFromHex(s)  [UIColor colorWithRed:(((s &0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define KGreenColor KUIColorFromHex(0x45ba3c)
#define KRedColor KUIColorFromHex(0xf85d4a)
#define KAppDefaultColor KUIColorFromHex(0xff3529)
#define KLineColor KUIColorFromHex(0xeeeeee)
#define KTableBackgroundColor KUIColorFromHex(0xf2f2f2)
#define KFont(size)     [UIFont systemFontOfSize:size]


/**
 iPhone X 机型
 */
#define KDevice_Is_iPhoneX ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? YES : NO)
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



/**
 个人中心全部订单类型
 */
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

/**
 首页功能区跳转类型
 */
typedef NS_ENUM(NSInteger , HomePageFunctionJumpType) {
    /**  跳转至网页 */
    FunctionJumpWebView = 0 ,
    /** 9.9专区 跟  新品上线*/
    FunctionJumpAllGoods ,
    /**  今日秒杀 */
    FunctionJumpSecondKill ,
    /** 拼团福利 */
    FunctionJumpSpellGroup ,
    /** 云电话 */
    FunctionJumpCloudPhone ,
    /** 赏金文章 */
    FunctionJumpArticleList,
    /** 联盟商户 */
    FunctionJumpBusiness,
    /** 签到领奖 */
    FunctionJumpSignIn,
    /** 分享圈子 */
    FunctionJumpShareCircle,
    
};

/**
 首页滚动广告区跳转类型
 */
typedef NS_ENUM(NSInteger , HomePageBannerJumpType) {
    /**  跳转至网页 */
    BannerJumpWebView = 0 ,
    /** 跳转至商品详情 */
    BannerJumpGoodsDetails ,
    /** 拼团福利 */
    BannerJumpSpellGroup ,
    /** 生鲜超市 */
    BannerJumpFreshSupermarket ,
    /** 京东优选 */
    BannerJumpJingDongOptimization ,
    /** 跳转至积分商城 */
    BannerJumpExchangeStore ,
    
};

/**
 全部商品二级广告区跳转类型
 */
typedef NS_ENUM(NSInteger , AllGoodsCollectionHeaderJumpType) {
    /** 跳转至京东优选 */
    AllGoodsCollectionHeaderJumpJingDongOptimization = 0 ,
    /** 跳转至商品详情 */
    AllGoodsCollectionHeaderJumpGoodsDetails ,
    /** 跳转至自带浏览器 */
    AllGoodsCollectionHeaderJumpSafari ,
    /** 未识别类型不做跳转 */
    AllGoodsCollectionHeaderJumpNone ,
};


