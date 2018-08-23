//
//  NSDate+YNCalendar.h
//  Custom-DataPicker
//
//  Created by 黄秋伟 on 2017/3/28.
//  Copyright © 2017年 黄秋伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YNCalendar)

+ (NSCalendar *)getCalendar;
/**
 拆分时间 - 年月日时分秒

 @return 返回拆分对象
 */
- (NSDateComponents *)componentDate;

/**
 时间获取
 
 @return 返回合并的时间对象
 */
- (NSDate *)dateForYear:(int)year;
- (NSDate *)dateForYear:(int)year month:(int)month;
- (NSDate *)dateForYear:(int)year month:(int)month day:(int)day;
- (NSDate *)dateForYear:(int)year month:(int)month day:(int)day hour:(int)hour;
- (NSDate *)dateForYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute;
- (NSDate *)dateForYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second;


/**
 时间增加
 
 @return 返回增加后的时间
 */
- (NSDate *)addDateForYear:(int)year;
- (NSDate *)addDateForYear:(int)year month:(int)month;
- (NSDate *)addDateForYear:(int)year month:(int)month day:(int)day;
- (NSDate *)addDateForYear:(int)year month:(int)month day:(int)day hour:(int)hour;
- (NSDate *)addDateForYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute;
- (NSDate *)addDateForYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second;


/**
 对时间进行加减

 @param day 传入要加减的天数 如： -7 ，6等
 @return 返回修改后的时间
 */
- (NSDate *)calculateDateFormatter:(NSString *)format day:(int)day;
- (NSDate *)calculateDateFormatter:(NSString *)format month:(int)month;
// 获取多久之前的date
- (NSString *) compareDateWithTime:(NSDate*) compareDate;
// 比较相差几天
- (NSInteger) compareDateForDayWithTime:(NSDate*) compareDate;
/**
 date转化为字符串

 @param date 传入的date数据
 @param dateFormatString 转化的格式 - yyyy年MM月dd日hh时mm分ss秒
 @return 转化后的字符串
 */
+ (NSString *)stringForDate:(NSDate *)date dateFormatString:(NSString *)dateFormatString;


/**
 字符串转化为date

 @param dateString 传入的字符串
 @param dateFormatString 转化的格式 - yyyy年MM月dd日hh时mm分ss秒
 @return 转化后的字符串
 */
+ (NSDate *)dateForDateString:(NSString *)dateString dateFormatString:(NSString *)dateFormatString;
+ (NSDate *)dateForDateSince1970String:(NSString *)dateString dateFormatString:(NSString *)dateFormatString;

+ (NSString *)changeStringForDateStr:(NSString *)dateStr dateFormatString:(NSString *)dateFormatString changeFormat:(NSString *)changeFormat;
//将世界时间转化为中国区时间
+ (NSDate *)worldTimeToChinaTime:(NSDate *)date;
/**
 计算一个月有几天

 @return 返回这个月的天数
 */
- (int)numberDayForMonth;

- (int)numberWeekForMonth;

- (int)numberDayForWeek;

- (int)firstDayForMonth;

@end
