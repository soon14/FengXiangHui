//
//  ShareManager.m
//  SSKSports
//
//  Created by sun on 2018/6/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//


#import "ShareManager.h"

@implementation ShareManager

//#pragma mark - 将用户信息存入本地
//+ (void)saveUserInfo:(UserInfoModel *)infoModel {
//    [[NSUserDefaults standardUserDefaults] setObject:infoModel.token forKey:KUserToken];
//    [[NSUserDefaults standardUserDefaults] setObject:infoModel.nickName forKey:KNickName];
//    [[NSUserDefaults standardUserDefaults] setObject:infoModel.signName forKey:KSignName];
//    [[NSUserDefaults standardUserDefaults] setObject:infoModel.headId forKey:KHeadId];
//    [[NSUserDefaults standardUserDefaults] setObject:infoModel.isPush forKey:KIsPush];
//}
//
//#pragma mark - 清除用户信息
//+ (void)clearUserInfo {
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUserToken];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KNickName];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KSignName];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KHeadId];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KIsPush];
//}
//
//#pragma mark - 判断两个日期是否是同一天
//+ (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2 {
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
//    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
//    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
//}

@end
