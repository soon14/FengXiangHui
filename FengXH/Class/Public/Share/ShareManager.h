//
//  ShareManager.h
//  SSKSports
//
//  Created by sun on 2018/6/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfoModel,HomepageDataMenuDataModel,HomepageDataBannerDataModel;

@interface ShareManager : NSObject

#pragma mark - 将用户信息存入本地
+ (void)saveUserInfo:(UserInfoModel *)infoModel;

#pragma mark - 清除用户信息
+ (void)clearUserInfo;

#pragma mark - 获取当前时间戳有两种方法(以秒为单位)
+ (NSString *)getNowTimeTimestamp;

#pragma mark - 判断是否为纯数字
+ (BOOL)isPureInt:(NSString *)string;

#pragma mark - 传入 HomepageDataMenuDataModel 判断跳转至啥地方
+ (NSInteger)getHomePageFunctionJumpTypeWithMenuDataModel:(HomepageDataMenuDataModel *)menuModel;

#pragma mark - 传入 HomepageDataBannerDataModel 判断跳转至啥地方
+ (NSInteger)getHomePageBannerJumpTypeWithBannerDataModel:(HomepageDataBannerDataModel *)bannerModel;

#pragma mark - 全部商品二级分类的头视图 —— 传入 URLString 判断跳转至啥地方
+ (NSInteger)getAllGoodsCollectionHeaderJumpTypeWithLinkUrl:(NSString *)linkUrl;

#pragma mark - 将dic 转成字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

#pragma mark - 分享
+ (void)shareWithTitle:(NSString *)titleStr andMessage:(NSString *)message andUrl:(NSString *)urlStr andImg:(NSArray *)imgArr;

#pragma mark - 判断是否为数字（含小数）
+ (BOOL)isNumber:(NSString *)strValue;

@end
