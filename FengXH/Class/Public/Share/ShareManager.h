//
//  ShareManager.h
//  SSKSports
//
//  Created by sun on 2018/6/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfoModel,HomepageDataMenuDataModel,HomepageResultPictureModel;

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
+ (NSInteger)getHomePageFunctionJumpTypeWithMenuDataModel:(HomepageResultPictureModel *)menuModel;

#pragma mark - 传入 HomepageDataBannerDataModel 判断跳转至啥地方
+ (NSInteger)getHomePageBannerJumpTypeWithBannerDataModel:(HomepageResultPictureModel *)bannerModel;

#pragma mark - 全部商品二级分类的头视图 —— 传入 URLString 判断跳转至啥地方
+ (NSInteger)getAllGoodsCollectionHeaderJumpTypeWithLinkUrl:(NSString *)linkUrl;

#pragma mark - 将dic 转成字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

#pragma mark - 宽度固定为屏幕宽度，获取图片高度
+ (CGFloat)getImageHeight:(NSString *)imageName;

#pragma mark - 分享
+ (void)shareWithTitle:(NSString *)titleStr andMessage:(NSString *)message andUrl:(NSString *)urlStr andImg:(NSArray *)imgArr;

#pragma mark - 判断是否为数字（含小数）
+ (BOOL)isNumber:(NSString *)strValue;

#pragma mark - 根据date获取当月总天数
+ (NSInteger)convertDateToTotalDays:(NSDate *)date;

#pragma mark - 根据date获取当月1号周几
+ (NSInteger)convertDateToFirstWeekDay:(NSDate *)date;

#pragma mark - 获取当前年月
+ (NSString *)getNowTimeYearMonthstamp;

#pragma mark - 获取当前日
+ (NSString *)getNowTimeDaystamp;

@end
