//
//  YNDatePickerView.h
//  Yoonen
//
//  Created by 黄秋伟 on 2017/3/24.
//  Copyright © 2017年 yoonen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+YNCalendar.h"
@class YNDatePickerView;

@protocol YNDatePickerViewDelegate <NSObject>

- (void)didSelectDatePickerView:(YNDatePickerView *)datePickerView selectDate:(NSDate *)date;

@end

typedef enum {
    YNDatePickerViewModelYear = 0,          //年
    YNDatePickerViewModelYearForMonth = 1,  //年-月
    YNDatePickerViewModelYearForDay = 2,    //年-月-日
    YNDatePickerViewModelYearForHour = 3,   //年-月-日-时
    YNDatePickerViewModelYearForMunite = 4, //年-月-日-时-分
    YNDatePickerViewModelMonthForDay = 5,   //月-日
    YNDatePickerViewModelMonthForHour = 6,  //月-日-时
    YNDatePickerViewModelMonthForMunite = 7,//月-日-时-分
    YNDatePickerViewModelMonthForSecond = 8,//月-日-时-分-秒
    YNDatePickerViewModelDay = 9,    // 日
    YNDatePickerViewModelDayForHour = 10,  //日-时
    YNDatePickerViewModelDayForMunite = 11,//日-时-分
    YNDatePickerViewModelDayForSecond = 12,//日-时-分-秒
    YNDatePickerViewModelHour = 13,          //时
    YNDatePickerViewModelHourForMunite = 14,//时-分
    YNDatePickerViewModelHourForSecond = 15,//时-分-秒
    YNDatePickerViewModelDateForTime = 16   //年-月-日-时-分-秒
} YNDatePickerViewModel;

@interface YNDatePickerView : UIView

/**
 *  获取DatePickAlertView对象
 *
 *  @return 返回实例对象
 */
+ (YNDatePickerView *)initialize;

/**
 弹出框显示
 
 @param title 输入标题
 @param delegate 传代理方法
 @param pickerMode 选择展示的时间类型
 date 初始展示的date
 maxDate 显示最大的日期
 minDate 显示最小的日期
 nameEnable 是否显示时间单位
 crossEnable 是否横屏显示
 */
- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id )delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode;

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id )delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
                        titleNameEnable:(BOOL)nameEnable;

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id )delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
                            defaultDate:(NSDate *)date;

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id )delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
                            defaultDate:(NSDate *)date
                                maxDate:(NSDate *)maxDate
                                minDate:(NSDate *)minDate;

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id )delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
                            defaultDate:(NSDate *)date
                                maxDate:(NSDate *)maxDate
                                minDate:(NSDate *)minDate
                        titleNameEnable:(BOOL)nameEnable;

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id )delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
                            defaultDate:(NSDate *)date
                                maxDate:(NSDate *)maxDate
                                minDate:(NSDate *)minDate
                        titleNameEnable:(BOOL)nameEnable
                         windorPosition:(BOOL)crossEnable;



/**
 *  添加代理对象
 */
@property (weak, nonatomic)id<YNDatePickerViewDelegate> delegate;
@property (assign, nonatomic)NSInteger pickerTag; // 标识
@end
