//
//  NSDate+YNCalendar.m
//  Custom-DataPicker
//
//  Created by 黄秋伟 on 2017/3/28.
//  Copyright © 2017年 黄秋伟. All rights reserved.
//

#import "NSDate+YNCalendar.h"

@implementation NSDate (YNCalendar)

+ (NSCalendar *)getCalendar {
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return calendar;
}

// 时间拆分 -  年月日时分秒
- (NSDateComponents *)componentDate {
    NSCalendar *calendar = [NSDate getCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth fromDate:self];
    return component;
}

// 时间获取
- (NSDate *)dateForYear:(int)year {
    return [self dateForYear:year month:1];
}
- (NSDate *)dateForYear:(int)year month:(int)month {
    return [self dateForYear:year month:month day:1];
}
- (NSDate *)dateForYear:(int)year month:(int)month day:(int)day {
    return [self dateForYear:year month:month day:day hour:1];
}
- (NSDate *)dateForYear:(int)year month:(int)month day:(int)day hour:(int)hour {
    return [self dateForYear:year month:month day:day hour:hour minute:1];
}
- (NSDate *)dateForYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute {
    return  [self dateForYear:year month:month day:day hour:hour minute:minute second:1];
}
- (NSDate *)dateForYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second {
    NSDateComponents *component = [[NSDateComponents alloc]init];
    component.timeZone = [NSTimeZone systemTimeZone];
    component.year = year;
    component.month = month;
    component.day = day;
    component.hour = hour;
    component.minute = minute;
    component.second = second;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:component];
    return date;
}

// 时间增加
- (NSDate *)addDateForYear:(int)year {
    return [self addDateForYear:year month:1];
}
- (NSDate *)addDateForYear:(int)year month:(int)month {
    return [self addDateForYear:year month:month day:1];
}
- (NSDate *)addDateForYear:(int)year month:(int)month day:(int)day {
    return [self addDateForYear:year month:month day:day hour:1];
}
- (NSDate *)addDateForYear:(int)year month:(int)month day:(int)day hour:(int)hour {
    return [self addDateForYear:year month:month day:day hour:hour minute:1];
}
- (NSDate *)addDateForYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute {
    return  [self addDateForYear:year month:month day:day hour:hour minute:minute second:1];
}
- (NSDate *)addDateForYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second {
    NSDateComponents * component = [[NSDateComponents alloc] init];
    if (year != 0) {
        component.year = year;
    }
    if (month != 0) {
        component.month = month;
    }
    if (day != 0) {
        component.day = day;
    }
    if (hour != 0) {
        component.hour = hour;
    }
    if (minute != 0) {
        component.minute = minute;
    }
    if (second != 0) {
        component.second = second;
    }
    
    NSDate * nextDate = [[NSDate getCalendar] dateByAddingComponents:component toDate:self options:NSCalendarMatchStrictly];
    return nextDate;
}

// 天数加减
- (NSDate *)calculateDateFormatter:(NSString *)format day:(int)day {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSTimeInterval interval = 60 * 60 * 24 * day;

    return [self initWithTimeInterval:interval sinceDate:self];
}

- (NSDate *)calculateDateFormatter:(NSString *)format month:(int)month {
    
    NSDateComponents *component = [self componentDate];
    [component setMonth:component.month + month];
    
    return [[NSDate getCalendar] dateFromComponents:component];
}

// 获取多久之前的date
- (NSString *) compareDateWithTime:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [self timeIntervalSinceDate:compareDate];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

// 比较时间大小
- (NSInteger)compareDateForDayWithTime:(NSDate *)compareDate {

    NSDateComponents *currentComponent = [self componentDate];
    NSDateComponents *compareComponent = [self componentDate];
    if (currentComponent.year < compareComponent.year) {
        return -1;
    } else if (currentComponent.year > compareComponent.year) {
        return 1;
    } else {
        if(currentComponent.month < compareComponent.month) {
            return -1;
        } else if (currentComponent.month >  compareComponent.month) {
            return 1;
        } else {
            if (currentComponent.day < compareComponent.day) {
                return -1;
            } else if (currentComponent.day > compareComponent.day) {
                return 1;
            } else {
                return 0;
            }
        }
    }

    return 0;
}


// 日期转化为字符串
+ (NSString *)stringForDate:(NSDate *)date dateFormatString:(NSString *)dateFormatString {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    formatter.dateFormat = dateFormatString;
    return [formatter stringFromDate:date];
}

// 字符串转化为日期
+ (NSDate *)dateForDateString:(NSString *)dateString dateFormatString:(NSString *)dateFormatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateFormat = dateFormatString;
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

// 更改字符串样式
+ (NSString *)changeStringForDateStr:(NSString *)dateStr
                    dateFormatString:(NSString *)dateFormatString
                        changeFormat:(NSString *)changeFormat {
    NSDate *date = [NSDate dateForDateString:dateStr dateFormatString:dateFormatString];
    NSString *str = [NSDate stringForDate:date dateFormatString:changeFormat];
    return str;
}

+ (NSDate *)dateForDateSince1970String:(NSString *)dateString dateFormatString:(NSString *)dateFormatString {
    if (dateFormatString == nil)
    {
        return nil;
    }
    double date = [dateFormatString doubleValue];//转成long long,毫秒数
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:date/1000.0];
    return [NSDate worldTimeToChinaTime:currentDate];
}

//将世界时间转化为中国区时间
+ (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

// 这个月有几天
- (int)numberDayForMonth {
    NSCalendar *calendar = [NSDate getCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    int numberDay = (int)range.length;
    return numberDay;
}
// 本月有几周
- (int)numberWeekForMonth {
    NSCalendar *calendar = [NSDate getCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:self];
    int numberWeek = (int)range.length;
    return numberWeek;
}

- (int)numberDayForWeek {
    NSDateComponents *com = [self componentDate];
    return (int)[com weekday];
}
// 本月第一天周几
- (int)firstDayForMonth {
//    [[NSDate getCalendar] setFirstWeekday:2];//设定周一为周首日
    NSDateComponents *coms = [self componentDate];
    NSDate *firDay = [self dateForYear:(int)coms.year month:(int)coms.month day:1];
    int firDayWeakNum = [firDay numberDayForWeek];
    return firDayWeakNum;
}
/*
yy: 年的后2位
yyyy: 完整年
MM: 月，显示为1-12
MMM: 月，显示为英文月份简写,如 Jan
MMMM: 月，显示为英文月份全称，如 Janualy
dd: 日，2位数表示，如02
d: 日，1-2位显示，如 2
EEE: 简写星期几，如Sun
EEEE: 全写星期几，如Sunday
aa: 上下午，AM/PM
H: 时，24小时制，0-23
K：时，12小时制，0-11
m: 分，1-2位
mm: 分，2位
s: 秒，1-2位
ss: 秒，2位
S: 毫秒
*/

@end
