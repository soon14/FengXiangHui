//
//  YNDatePickerView.m
//  Yoonen
//
//  Created by 黄秋伟 on 2017/3/24.
//  Copyright © 2017年 yoonen. All rights reserved.
//

#import "YNDatePickerView.h"

@interface YNDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    int pickNum;
    CGFloat labelWidth;
    CGFloat labelHeight;
    NSDate *_defaultDate;
    NSDate *_maxDate;
    NSDate *_minDate;
    
    int yearRow;
    int monthRow;
    int dayRow;
    int hourRow;
    int muniteRow;
    int secondRow;
    
    int yearData;
    int monthData;
    int dayData;
    int hourData;
    int muniteData;
    int secondData;
    
    BOOL titleNameEnable;
    BOOL initEnable;
}

// UI
@property (strong, nonatomic)UIView *alertView;
@property (strong, nonatomic)UIButton *backView;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UIView *titleLine;
@property (strong, nonatomic)UIPickerView *pickView;
@property (strong, nonatomic)UIView *contentLine;
@property (strong, nonatomic)UIView *selectCenterLine;
@property (strong, nonatomic)UIButton *selectButton;
@property (strong, nonatomic)UIButton *unSelectButton;
// datasoruce
@property (strong, nonatomic) NSMutableArray *yearArr;
@property (strong, nonatomic) NSMutableArray *monthArr;
@property (strong, nonatomic) NSMutableArray *dayArr;
@property (strong, nonatomic) NSMutableArray *hourArr;
@property (strong, nonatomic) NSMutableArray *muniteArr;
@property (strong, nonatomic) NSMutableArray *secondArr;
// tool
@property (strong, nonatomic) NSDate *currentDate;
@property (assign, nonatomic) YNDatePickerViewModel pickerModel;
@end

@implementation YNDatePickerView

#pragma mark - 外部调用

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id)delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
{
    [self showCustomDatePickViewWithTitle:title target:delegate datePickerViewModel:pickerMode defaultDate:nil];
}

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id )delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
                        titleNameEnable:(BOOL)nameEnable {
    [self showCustomDatePickViewWithTitle:title target:delegate datePickerViewModel:pickerMode defaultDate:nil maxDate:nil minDate:nil titleNameEnable:nameEnable];
}

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id)delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
                            defaultDate:(NSDate *)date
{
    [self showCustomDatePickViewWithTitle:title target:delegate datePickerViewModel:pickerMode defaultDate:date maxDate:nil minDate:nil];
}

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id)delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
                            defaultDate:(NSDate *)date
                                maxDate:(NSDate *)maxDate
                                minDate:(NSDate *)minDate
{
    [self showCustomDatePickViewWithTitle:title target:delegate datePickerViewModel:pickerMode defaultDate:date maxDate:maxDate minDate:minDate titleNameEnable:NO];
}

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id)delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
                            defaultDate:(NSDate *)date
                                maxDate:(NSDate *)maxDate
                                minDate:(NSDate *)minDate
                        titleNameEnable:(BOOL)nameEnable
{
    [self showCustomDatePickViewWithTitle:title target:delegate datePickerViewModel:pickerMode defaultDate:date maxDate:maxDate minDate:minDate titleNameEnable:nameEnable windorPosition:NO];
}

- (void)showCustomDatePickViewWithTitle:(NSString *)title
                                 target:(id)delegate
                    datePickerViewModel:(YNDatePickerViewModel)pickerMode
                            defaultDate:(NSDate *)date
                                maxDate:(NSDate *)maxDate
                                minDate:(NSDate *)minDate
                        titleNameEnable:(BOOL)nameEnable
                         windorPosition:(BOOL)crossEnable
{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alertView.layer.cornerRadius = 5;
    self.alertView.clipsToBounds = YES;
    titleNameEnable = nameEnable;
    initEnable = YES;
    self.delegate = delegate;
    _pickerModel = pickerMode;
    if (title != nil) {
        self.titleLabel.text = title;
    }
    if (maxDate) {
        _maxDate = maxDate;
    } else {
        NSDate *current = [NSDate date];
        NSInteger year = [current componentDate].year;
        _maxDate = [current dateForYear:(int)year];
    }
    
    if (minDate) {
        _minDate = minDate;
    } else {
        NSDate *current = [NSDate date];
        NSInteger year = [current componentDate].year;
        _minDate = [current dateForYear:(int)year - 3];
    }
    
    if (date != nil) {
        _defaultDate = date;
    } else {
        _defaultDate = [NSDate date];
    }

    NSDateComponents *component = [_defaultDate componentDate];
    yearData = (int)component.year;
    monthData = (int)component.month;
    dayData = (int)component.day;
    muniteData = (int)component.minute;
    hourData = (int)component.hour;
    secondData = (int)component.second;
    
    if (crossEnable) {
        self.frame = CGRectMake(-(KMAINSIZE.height/2 - KMAINSIZE.width/2), 0, KMAINSIZE.width, KMAINSIZE.height);
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.backView.frame = self.bounds;
    }
    
    [self configData];
    [self showAnimal];
}

#pragma mark - 初始化

+ (YNDatePickerView *)initialize {
    YNDatePickerView *selfView = [[YNDatePickerView alloc]init];
    return selfView;
}

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self addSubview:self.backView];
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.titleLine];
        [self.alertView addSubview:self.pickView];
        [self.alertView addSubview:self.contentLine];
        [self.alertView addSubview:self.selectCenterLine];
        [self.alertView addSubview:self.selectButton];
        [self.alertView addSubview:self.unSelectButton];
//        [self layoutIfNeeded];
        [self configLayout];
    }
    return self;
}

- (void)configLayout {
    CGFloat alertWidth = KMAINSIZE.width - 60;
    CGFloat alertHeight = 280;
    self.backView.frame = CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height);
    self.alertView.frame = CGRectMake(30, 0, alertWidth, 280);
    self.titleLabel.frame = CGRectMake(0, 0, alertWidth, 56);
    self.titleLine.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), alertWidth, 1);
    self.pickView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLine.frame) + 10, alertWidth, 155);
    self.contentLine.frame = CGRectMake(0, CGRectGetMaxY(self.pickView.frame) + 10, alertWidth, 1);
    self.selectCenterLine.frame = CGRectMake(alertWidth/2, CGRectGetMaxY(self.contentLine.frame), 1, alertHeight - CGRectGetMaxY(self.contentLine.frame));
    self.unSelectButton.frame = CGRectMake(0, CGRectGetMaxY(self.contentLine.frame), alertWidth/2, alertHeight - CGRectGetMaxY(self.contentLine.frame));
    self.selectButton.frame = CGRectMake(alertWidth/2+1, CGRectGetMaxY(self.contentLine.frame), alertWidth/2, alertHeight - CGRectGetMaxY(self.contentLine.frame));
    self.alertView.center = self.center;
}

#pragma mark - pickView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return pickNum;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger number = 0;

    if (component == 0) {
        switch (_pickerModel) {
            case YNDatePickerViewModelYear:
            case YNDatePickerViewModelYearForMonth:
            case YNDatePickerViewModelYearForDay:
            case YNDatePickerViewModelYearForHour:
            case YNDatePickerViewModelYearForMunite:
            case YNDatePickerViewModelDateForTime:
                number = self.yearArr.count;
                break;
            case YNDatePickerViewModelMonthForDay:
            case YNDatePickerViewModelMonthForHour:
            case YNDatePickerViewModelMonthForMunite:
            case YNDatePickerViewModelMonthForSecond:
                number = self.monthArr.count;
                break;
            case YNDatePickerViewModelDay:
            case YNDatePickerViewModelDayForHour:
            case YNDatePickerViewModelDayForMunite:
            case YNDatePickerViewModelDayForSecond:
                number = self.dayArr.count;
                break;
            case YNDatePickerViewModelHour:
            case YNDatePickerViewModelHourForMunite:
            case YNDatePickerViewModelHourForSecond:
                number = self.hourArr.count;
                break;
            default:
                break;
        }
    } else if (component == 1) {
        switch (_pickerModel) {
            case YNDatePickerViewModelYearForMonth:
            case YNDatePickerViewModelYearForDay:
            case YNDatePickerViewModelYearForHour:
            case YNDatePickerViewModelYearForMunite:
            case YNDatePickerViewModelDateForTime:
                number = self.monthArr.count;
                break;
            case YNDatePickerViewModelMonthForDay:
            case YNDatePickerViewModelMonthForHour:
            case YNDatePickerViewModelMonthForMunite:
            case YNDatePickerViewModelMonthForSecond:
                number = self.dayArr.count;
                break;
            case YNDatePickerViewModelDayForHour:
            case YNDatePickerViewModelDayForMunite:
            case YNDatePickerViewModelDayForSecond:
                number = self.hourArr.count;
                break;
            case YNDatePickerViewModelHourForMunite:
            case YNDatePickerViewModelHourForSecond:
                number = self.muniteArr.count;
                break;
            default:
                break;
        }
    } else if (component == 2) {
        switch (_pickerModel) {
            case YNDatePickerViewModelYearForDay:
            case YNDatePickerViewModelYearForHour:
            case YNDatePickerViewModelYearForMunite:
            case YNDatePickerViewModelDateForTime:
                number = self.dayArr.count;
                break;
            case YNDatePickerViewModelMonthForHour
                :
            case YNDatePickerViewModelMonthForMunite:
            case YNDatePickerViewModelMonthForSecond:
                number = self.hourArr.count;
                break;
            case YNDatePickerViewModelDayForMunite:
            case YNDatePickerViewModelDayForSecond:
                number = self.muniteArr.count;
                break;
            case YNDatePickerViewModelHourForSecond:
                number = self.secondArr.count;
                break;
            default:
                break;
        }
    } else if (component == 3) {
        switch (_pickerModel) {
            case YNDatePickerViewModelYearForHour:
            case YNDatePickerViewModelYearForMunite:
            case YNDatePickerViewModelDateForTime:
                number = self.hourArr.count;
                break;
            case YNDatePickerViewModelMonthForMunite:
            case YNDatePickerViewModelMonthForSecond:
                number = self.muniteArr.count;
                break;
            case YNDatePickerViewModelDayForSecond:
                number = self.secondArr.count;
                break;
            default:
                break;
        }
    } else if (component == 4){
        switch (_pickerModel) {
            case YNDatePickerViewModelYearForMunite:
            case YNDatePickerViewModelDateForTime:
                number = self.muniteArr.count;
                break;
            case YNDatePickerViewModelMonthForSecond:
                number = self.secondArr.count;
                break;
            default:
                break;
        }
    } else {
        number = self.secondArr.count;
    }
    
    return number;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {

    return labelWidth;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    [self clearSeparatorWithView:pickerView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, labelHeight)];
    label.textColor = [UIColor colorWithRed:146.0/255 green:147.0/255 blue:147.0/255 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.text = [self reloadDataWithComponent:component row:row];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    
    // 处理月份计算的天数
    switch (_pickerModel) {
        case YNDatePickerViewModelYear:
            yearData = [self.yearArr[row] intValue];
            yearRow = (int)row;
            break;
        case YNDatePickerViewModelYearForMonth:
            if (component == 0) {
                yearData = [self.yearArr[row] intValue];
                yearRow = (int)row;
            } else {
                monthData = [self.monthArr[row] intValue];
                monthRow = (int)row;
            }
            break;
        case YNDatePickerViewModelYearForDay:
            if (component == 0) {
                yearData = [self.yearArr[row] intValue];
                yearRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else if (component == 1){
                monthData = [self.monthArr[row] intValue];
                monthRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else {
                dayData = [self.dayArr[row] intValue];
                dayRow = (int)row;
            }
            break;
        case YNDatePickerViewModelYearForHour:
            if (component == 0) {
                yearData = [self.yearArr[row] intValue];
                yearRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else if (component == 1){
                monthData = [self.monthArr[row] intValue];
                monthRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else if (component == 2){
                dayData = [self.dayArr[row] intValue];
                dayRow = (int)row;
            } else {
                hourData = [self.hourArr[row] intValue];
                hourRow = (int)row;
            }
            break;
        case YNDatePickerViewModelYearForMunite:
            if (component == 0) {
                yearData = [self.yearArr[row] intValue];
                yearRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else if (component == 1){
                monthData = [self.monthArr[row] intValue];
                monthRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else if (component == 2){
                dayData = [self.dayArr[row] intValue];
                dayRow = (int)row;
            } else if (component == 3){
                hourRow = (int)row;
                hourData = [self.hourArr[row] intValue];
            } else {
                muniteData = [self.muniteArr[row] intValue];
                muniteRow = (int)row;
            }
            break;
        case YNDatePickerViewModelMonthForDay:
            if (component == 0){
                monthData = [self.monthArr[row] intValue];
                muniteRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else {
                dayData = [self.dayArr[row] intValue];
                dayRow = (int)row;
            }
            break;
        case YNDatePickerViewModelMonthForHour:
            if (component == 0){
                monthData = [self.monthArr[row] intValue];
                monthRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else if (component == 1){
                dayData = [self.dayArr[row] intValue];
                dayRow = (int)row;
            } else {
                hourData = [self.hourArr[row] intValue];
                hourRow = (int)row;
            }
            break;
        case YNDatePickerViewModelMonthForMunite:
            if (component == 0){
                monthData = [self.monthArr[row] intValue];
                monthRow = (int)row;
               [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else if (component == 1){
                dayData = [self.dayArr[row] intValue];
                dayRow = (int)row;
            } else if (component == 2){
                hourData = [self.hourArr[row] intValue];
                hourRow = (int)row;
            } else {
                muniteData = [self.muniteArr[row] intValue];
                muniteRow = (int)row;
            }
            break;
        case YNDatePickerViewModelMonthForSecond:
            if (component == 0){
                monthData = [self.monthArr[row] intValue];
                monthRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else if (component == 1){
                dayData = [self.dayArr[row] intValue];
                dayRow = (int)row;
            } else if (component == 2){
                hourData = [self.hourArr[row] intValue];
                hourRow = (int)row;
            } else if (component == 3){
                muniteData = [self.muniteArr[row] intValue];
                muniteRow = (int)row;
            } else {
                secondData = [self.secondArr[row] intValue];
                secondRow = (int)row;
            }
            break;
        case YNDatePickerViewModelHour:
            hourData = [self.hourArr[row] intValue];
            hourRow = (int)row;
            break;
        case YNDatePickerViewModelHourForMunite:
            if (component == 0){
                hourData = [self.hourArr[row] intValue];
                hourRow = (int)row;
            } else {
                muniteData = [self.muniteArr[row] intValue];
                muniteRow = (int)row;
            }
            break;
        case YNDatePickerViewModelHourForSecond:
            if (component == 0){
                hourData = [self.hourArr[row] intValue];
                hourRow = (int)row;
            } else if (component == 1){
                muniteData = [self.muniteArr[row] intValue];
                muniteRow = (int)row;
            } else {
                secondData = [self.secondArr[row] intValue];
                secondRow = (int)row;
            }
            break;
        case YNDatePickerViewModelDateForTime:
            if (component == 0) {
                yearData = [self.yearArr[row] intValue];
                yearRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else if (component == 1){
                monthData = [self.monthArr[row] intValue];
                monthRow = (int)row;
                [self getDaysWithYear:yearData month:monthData];
                [self.pickView reloadAllComponents];
            } else if (component == 2){
                dayData = [self.dayArr[row] intValue];
                dayRow = (int)row;
            } else if (component == 3){
                hourData = [self.hourArr[row] intValue];
                hourRow = (int)row;
            } else if (component == 4){
                muniteData = [self.muniteArr[row] intValue];
                muniteRow = (int)row;
            } else {
                secondData = [self.secondArr[row] intValue];
                secondRow = (int)row;
            }
            break;
        case YNDatePickerViewModelDay:
        case YNDatePickerViewModelDayForHour:
        case YNDatePickerViewModelDayForMunite:
        case YNDatePickerViewModelDayForSecond:
            if (component == 0){
                dayData = [self.dayArr[row] intValue];
                dayRow = (int)row;
            } else if (component == 1){
                hourData = [self.hourArr[row] intValue];
                hourRow = (int)row;
            } else if (component == 2){
                muniteData = [self.muniteArr[row] intValue];
                muniteRow = (int)row;
            } else {
                secondData = [self.secondArr[row] intValue];
                secondRow = (int)row;
            }
            break;
        default:
            break;
    }
    

    _defaultDate = [_defaultDate dateForYear:yearData month:monthData day:dayData hour:hourData minute:muniteData second:secondData];
}

// 删除自带两条线
- (void)clearSeparatorWithView:(UIView * )view {
    if(view.subviews != 0) {
        if(view.bounds.size.height < 5) {
            view.backgroundColor = [UIColor clearColor];
        }
        [view.subviews enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL *stop) {
            [self clearSeparatorWithView:obj];
        }];
    }
}
#pragma mark - data tool

- (void)configData {
    int year = (int)[_defaultDate componentDate].year;
    int month = (int)[_defaultDate componentDate].month;
    
    [self getYearsArr];
    [self getMonthArr];
    [self getDaysWithYear:year month:month];
    [self getHourArr];
    [self getMinuteArr];
    [self getSecondArr];
    [self reloadNumberForPicker];
    [self didSelectRow];
}

// 获取年数据
- (void)getYearsArr {
    int minYear = (int)[_minDate componentDate].year;
    int maxYear = (int)[_maxDate componentDate].year;
    [self.yearArr removeAllObjects];
    int numrow = 0;
    for (int index = minYear; index <= maxYear; index ++) {
        if (index == yearData) {
            yearRow = numrow;
        }
        numrow++;
        if (index < 10) {
            [self.yearArr addObject:[NSString stringWithFormat:@"%0d",index]];
        } else {
            [self.yearArr addObject:[NSString stringWithFormat:@"%d",index]];
        }
    }
};

// 获取本年-月数据
- (void)getMonthArr {
    
    int numrow = 0;
    for (int index = 1; index <= 12; index ++) {
        if (index == monthData) {
            monthRow = numrow;
        }
        numrow ++;
        if (index < 10) {
            [self.monthArr addObject:[NSString stringWithFormat:@"%0d",index]];
        } else {
            [self.monthArr addObject:[NSString stringWithFormat:@"%d",index]];
        }
    }
}

// 获取本月-天数据
- (void)getDaysWithYear:(int)year month:(int)month {
    NSDate *currentMonth = [[NSDate date] dateForYear:year month:month];
    int numberDays = [currentMonth numberDayForMonth];
    [self.dayArr removeAllObjects];
    if (dayData > numberDays) {
        if (dayData > 0) {
            dayRow = numberDays - 1;
            dayData = numberDays;
        } else {
            dayRow = 0;
            dayData = 1;
        }
    }
    
    int numrow = 0;
    for (int index = 1; index <= numberDays; index ++) {
        if (dayData == index) {
            dayRow = numrow;
            dayData = index;
        }

        numrow++;
        if (index < 10) {
            [self.dayArr addObject:[NSString stringWithFormat:@"0%d",index]];
        } else {
            [self.dayArr addObject:[NSString stringWithFormat:@"%d",index]];
        }
    }
    
    if (!initEnable) {
        [self didSelectRow];
    } else {
        initEnable = NO;
    }
};

// 获取时数据
- (void)getHourArr {
    int numrow = 0;
    for (int index = 1; index <= 24; index ++) {
        if (index == hourData) {
            hourRow = numrow;
        }
        numrow ++;
        if (index < 10) {
            [self.hourArr addObject:[NSString stringWithFormat:@"0%d",index]];
        } else {
            [self.hourArr addObject:[NSString stringWithFormat:@"%d",index]];
        }
    }
}

// 获取分数据
- (void)getMinuteArr {
    int numrow = 0;
    for (int index = 1; index <= 60; index ++) {
        if (index == muniteData) {
            muniteRow = numrow;
        }
        numrow ++;
        if (index < 10) {
            [self.muniteArr addObject:[NSString stringWithFormat:@"0%d",index]];
        } else {
            [self.muniteArr addObject:[NSString stringWithFormat:@"%d",index]];
        }
        
    }
}

// 获取秒数据
- (void)getSecondArr {
    int numrow = 0;
    for (int index = 1; index <= 60; index ++) {
        if (index == secondData) {
            secondRow = numrow;
        }
        numrow ++;
        if (index < 10) {
            [self.secondArr addObject:[NSString stringWithFormat:@"0%d",index]];
        } else {
            [self.secondArr addObject:[NSString stringWithFormat:@"%d",index]];
        }
        
    }
}

- (NSMutableArray *)yearArr {
    if (!_yearArr) {
        _yearArr = [NSMutableArray array];
    }
    return _yearArr;
}

- (NSMutableArray *)monthArr {
    if (!_monthArr) {
        _monthArr = [NSMutableArray array];
        for (int index = 1; index <= 12; index ++) {
            if (index < 10) {
                [_monthArr addObject:[NSString stringWithFormat:@"0%d",index]];
            } else {
                [_monthArr addObject:[NSString stringWithFormat:@"%d",index]];
            }
            
        }
    }
    return _monthArr;
}

- (NSMutableArray *)dayArr {
    if (!_dayArr) {
        _dayArr = [NSMutableArray array];
    }
    return _dayArr;
}

- (NSMutableArray *)hourArr {
    if (!_hourArr) {
        _hourArr = [NSMutableArray array];
    }
    return _hourArr;
}

- (NSMutableArray *)muniteArr {
    if (!_muniteArr) {
        _muniteArr = [NSMutableArray array];
    }
    return _muniteArr;
}

- (NSMutableArray *)secondArr {
    if (!_secondArr) {
        _secondArr = [NSMutableArray array];
    }
    return _secondArr;
}

#pragma mark - model 操作

- (void)didSelectRow{
    
    switch (_pickerModel) {
        case YNDatePickerViewModelYear:
            [self.pickView selectRow:yearRow inComponent:0 animated:NO];
            break;
        case YNDatePickerViewModelYearForMonth:
            [self.pickView selectRow:yearRow inComponent:0 animated:NO];
            [self.pickView selectRow:monthRow inComponent:1 animated:NO];
            break;
        case YNDatePickerViewModelYearForDay:
            [self.pickView selectRow:yearRow inComponent:0 animated:NO];
            [self.pickView selectRow:monthRow inComponent:1 animated:NO];
            [self.pickView selectRow:dayRow inComponent:2 animated:NO];
            break;
        case YNDatePickerViewModelYearForHour:
            [self.pickView selectRow:yearRow inComponent:0 animated:NO];
            [self.pickView selectRow:monthRow inComponent:1 animated:NO];
            [self.pickView selectRow:dayRow inComponent:2 animated:NO];
            [self.pickView selectRow:hourRow inComponent:3 animated:NO];
            break;
        case YNDatePickerViewModelYearForMunite:
            [self.pickView selectRow:yearRow inComponent:0 animated:NO];
            [self.pickView selectRow:monthRow inComponent:1 animated:NO];
            [self.pickView selectRow:dayRow inComponent:2 animated:NO];
            [self.pickView selectRow:hourRow inComponent:3 animated:NO];
            [self.pickView selectRow:muniteRow inComponent:4 animated:NO];
            break;
        case YNDatePickerViewModelMonthForDay:
            [self.pickView selectRow:monthRow inComponent:0 animated:NO];
            [self.pickView selectRow:dayRow inComponent:1 animated:NO];
            break;
        case YNDatePickerViewModelMonthForHour:
            [self.pickView selectRow:monthRow inComponent:0 animated:NO];
            [self.pickView selectRow:dayRow inComponent:1 animated:NO];
            [self.pickView selectRow:hourRow inComponent:2 animated:NO];
            break;
        case YNDatePickerViewModelMonthForMunite:
            [self.pickView selectRow:monthRow inComponent:0 animated:NO];
            [self.pickView selectRow:dayRow inComponent:1 animated:NO];
            [self.pickView selectRow:hourRow inComponent:2 animated:NO];
            [self.pickView selectRow:muniteRow inComponent:3 animated:NO];
            break;
        case YNDatePickerViewModelMonthForSecond:
            [self.pickView selectRow:monthRow inComponent:0 animated:NO];
            [self.pickView selectRow:dayRow inComponent:1 animated:NO];
            [self.pickView selectRow:hourRow inComponent:2 animated:NO];
            [self.pickView selectRow:muniteRow inComponent:3 animated:NO];
            [self.pickView selectRow:secondRow inComponent:4 animated:NO];
            break;
        case YNDatePickerViewModelHour:
            [self.pickView selectRow:hourRow inComponent:0 animated:NO];
            break;
        case YNDatePickerViewModelHourForMunite:
            [self.pickView selectRow:hourRow inComponent:0 animated:NO];
            [self.pickView selectRow:muniteRow inComponent:1 animated:NO];
            break;
        case YNDatePickerViewModelHourForSecond:
            [self.pickView selectRow:hourRow inComponent:0 animated:NO];
            [self.pickView selectRow:muniteRow inComponent:1 animated:NO];
            [self.pickView selectRow:secondRow inComponent:2 animated:NO];
            break;
        case YNDatePickerViewModelDateForTime:
            [self.pickView selectRow:yearRow inComponent:0 animated:NO];
            [self.pickView selectRow:monthRow inComponent:1 animated:NO];
            [self.pickView selectRow:dayRow inComponent:2 animated:NO];
            [self.pickView selectRow:hourRow inComponent:3 animated:NO];
            [self.pickView selectRow:muniteRow inComponent:4 animated:NO];
            [self.pickView selectRow:secondRow inComponent:5 animated:NO];
            break;
        case YNDatePickerViewModelDay:
            [self.pickView selectRow:dayRow inComponent:0 animated:NO];
            break;
        case YNDatePickerViewModelDayForHour:
            [self.pickView selectRow:dayRow inComponent:0 animated:NO];
            [self.pickView selectRow:hourRow inComponent:1 animated:NO];
            break;
        case YNDatePickerViewModelDayForMunite:
            [self.pickView selectRow:dayRow inComponent:0 animated:NO];
            [self.pickView selectRow:hourRow inComponent:1 animated:NO];
            [self.pickView selectRow:muniteRow inComponent:2 animated:NO];
            break;
        case YNDatePickerViewModelDayForSecond:
            [self.pickView selectRow:dayRow inComponent:0 animated:NO];
            [self.pickView selectRow:hourRow inComponent:1 animated:NO];
            [self.pickView selectRow:muniteRow inComponent:2 animated:NO];
            [self.pickView selectRow:secondRow inComponent:3 animated:NO];
            break;
            
        default:
            break;
    }
}

- (NSString *)reloadDataWithComponent:(NSInteger)component row:(NSInteger)row{
    NSString *title = @"";
    if (component == 0) {
        switch (_pickerModel) {
            case YNDatePickerViewModelYear:
            case YNDatePickerViewModelYearForMonth:
            case YNDatePickerViewModelYearForDay:
            case YNDatePickerViewModelYearForHour:
            case YNDatePickerViewModelYearForMunite:
            case YNDatePickerViewModelDateForTime:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@年",self.yearArr[row]];
                } else {
                    title = self.yearArr[row];
                }
                break;
            case YNDatePickerViewModelMonthForDay:
            case YNDatePickerViewModelMonthForHour:
            case YNDatePickerViewModelMonthForMunite:
            case YNDatePickerViewModelMonthForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@月",self.monthArr[row]];
                } else {
                    title = self.monthArr[row];
                }
                break;
            case YNDatePickerViewModelDay:
            case YNDatePickerViewModelDayForHour:
            case YNDatePickerViewModelDayForMunite:
            case YNDatePickerViewModelDayForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@日",self.dayArr[row]];
                } else {
                    title = self.dayArr[row];
                }
                break;
            case YNDatePickerViewModelHour:
            case YNDatePickerViewModelHourForMunite:
            case YNDatePickerViewModelHourForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@时",self.hourArr[row]];
                } else {
                    title = self.hourArr[row];
                }
                break;
            default:
                break;
        }
    } else if (component == 1) {
        switch (_pickerModel) {
            case YNDatePickerViewModelYearForMonth:
            case YNDatePickerViewModelYearForDay:
            case YNDatePickerViewModelYearForHour:
            case YNDatePickerViewModelYearForMunite:
            case YNDatePickerViewModelDateForTime:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@月",self.monthArr[row]];
                } else {
                    title = self.monthArr[row];
                }
                break;
            case YNDatePickerViewModelMonthForDay:
            case YNDatePickerViewModelMonthForHour:
            case YNDatePickerViewModelMonthForMunite:
            case YNDatePickerViewModelMonthForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@日",self.dayArr[row]];
                } else {
                    title = self.dayArr[row];
                }
                break;
            case YNDatePickerViewModelDayForHour:
            case YNDatePickerViewModelDayForMunite:
            case YNDatePickerViewModelDayForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@时",self.hourArr[row]];
                } else {
                    title = self.hourArr[row];
                }
                break;
            case YNDatePickerViewModelHourForMunite:
            case YNDatePickerViewModelHourForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@分",self.muniteArr[row]];
                } else {
                    title = self.muniteArr[row];
                }
                break;
            default:
                break;
        }
    } else if (component == 2) {
        switch (_pickerModel) {
            case YNDatePickerViewModelYearForDay:
            case YNDatePickerViewModelYearForHour:
            case YNDatePickerViewModelYearForMunite:
            case YNDatePickerViewModelDateForTime:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@日",self.dayArr[row]];
                } else {
                    title = self.dayArr[row];
                }
                break;
            case YNDatePickerViewModelMonthForHour:
            case YNDatePickerViewModelMonthForMunite:
            case YNDatePickerViewModelMonthForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@时",self.hourArr[row]];
                } else {
                    title = self.hourArr[row];
                }
                break;
            case YNDatePickerViewModelDayForMunite:
            case YNDatePickerViewModelDayForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@分",self.muniteArr[row]];
                } else {
                    title = self.muniteArr[row];
                }
                break;
            case YNDatePickerViewModelHourForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@秒",self.secondArr[row]];
                } else {
                    title = self.secondArr[row];
                }
                break;
            default:
                break;
        }
    } else if (component == 3) {
        switch (_pickerModel) {
            case YNDatePickerViewModelYearForHour:
            case YNDatePickerViewModelYearForMunite:
            case YNDatePickerViewModelDateForTime:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@时",self.hourArr[row]];
                } else {
                    title = self.hourArr[row];
                }
                break;
            case YNDatePickerViewModelMonthForMunite:
            case YNDatePickerViewModelMonthForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@分",self.muniteArr[row]];
                } else {
                    title = self.muniteArr[row];
                }
                break;
            case YNDatePickerViewModelDayForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@秒",self.secondArr[row]];
                } else {
                    title = self.secondArr[row];
                }
                break;
            default:
                break;
        }
    } else if (component == 4){
        switch (_pickerModel) {
            case YNDatePickerViewModelYearForMunite:
            case YNDatePickerViewModelDateForTime:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@分",self.muniteArr[row]];
                } else {
                    title = self.muniteArr[row];
                }
                break;
            case YNDatePickerViewModelMonthForSecond:
                if (titleNameEnable) {
                    title = [NSString stringWithFormat:@"%@秒",self.secondArr[row]];
                } else {
                    title = self.secondArr[row];
                }
                break;
            default:
                break;
        }
    } else {
        title = self.secondArr[row];
    }
    
    return title;
}

- (void)reloadNumberForPicker {
    int number = 0;
    switch (_pickerModel) {
        case YNDatePickerViewModelYear:
        case YNDatePickerViewModelHour:
        case YNDatePickerViewModelDay:
            number = 1;
            break;
        case YNDatePickerViewModelYearForMonth:
        case YNDatePickerViewModelMonthForDay:
        case YNDatePickerViewModelHourForMunite:
        case YNDatePickerViewModelDayForHour:
            number = 2;
            break;
        case YNDatePickerViewModelYearForDay:
        case YNDatePickerViewModelMonthForHour:
        case YNDatePickerViewModelHourForSecond:
        case YNDatePickerViewModelDayForMunite:
            number = 3;
            break;
        case YNDatePickerViewModelYearForHour:
        case YNDatePickerViewModelMonthForMunite:
        case YNDatePickerViewModelDayForSecond:
            number = 4;
            break;
        case YNDatePickerViewModelYearForMunite:
        case YNDatePickerViewModelMonthForSecond:
            number = 5;
            break;
        case YNDatePickerViewModelDateForTime:
            number = 6;
            break;
        default:
            break;
    }
    pickNum = number;
    
    ////////////////////
    // 增加上下两天线 /////
    ////////////////////
    labelHeight = 30;
    if (number > 4) {
        labelWidth = (self.pickView.frame.size.width - (pickNum-1)*4.5) / pickNum;
    } else {
        labelWidth = (self.pickView.frame.size.width - 40 - (pickNum-1)*4.5) / pickNum;
    }
    
    for (int index = 0; index < number; index ++) {
        CGFloat labelX = 0;
        CGFloat labelWid;
        if (number > 4) {
            labelX = 4.5 * index + index * labelWidth;
            labelWid = labelWidth;
        } else {
            labelX = 20 + 4.5 * index + index * labelWidth;
            labelWid = labelWidth;
        }
        
        CGFloat centerY = self.pickView.frame.size.height/2 + self.pickView.frame.origin.y;
        
        UIView *lineTop = [[UIView alloc]initWithFrame:CGRectMake(labelX, centerY - labelHeight/2, labelWid , 1)];
        lineTop.backgroundColor = KUIColorFromHex(0x60c4e9);
        
        UIView *lineBottom = [[UIView alloc]initWithFrame:CGRectMake(labelX, centerY + labelHeight/2, labelWid , 1)];
        lineBottom.backgroundColor = KUIColorFromHex(0x60c4e9);
        
        [self.alertView addSubview:lineTop];
        [self.alertView addSubview:lineBottom];
    }
}

#pragma mark - Act

- (void)selectAct:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectDatePickerView:selectDate:)]) {
        [self.delegate didSelectDatePickerView:self selectDate:_defaultDate];
    }
    [self hiddenAnimal];
}

#pragma mark - animal

- (void)showAnimal {
    
    CGFloat startY = -(CGRectGetHeight([UIScreen mainScreen].bounds) + CGRectGetHeight(_alertView.frame)/2);
    
    _alertView.center    = CGPointMake(self.backView.center.x, startY);
    _alertView.transform = CGAffineTransformMakeRotation(45);
    
    typeof(self) __weak weak_self = self;
    
    [UIView animateWithDuration:0.5f animations:^{
        weak_self.backView.alpha = 0.64;
        weak_self.alertView.transform = CGAffineTransformMakeRotation(0);
        weak_self.alertView.center = CGPointMake(weak_self.backView.center.x,weak_self.backView.center.y);
    }completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenAnimal {
    
    _alertView.center    = CGPointMake(self.backView.center.x, self.backView.center.y);
    typeof(self) __weak weak_self = self;
    CGFloat endY = CGRectGetMaxY([UIScreen mainScreen].bounds);
    
    [UIView animateWithDuration:0.3f animations:^{
        weak_self.backView.alpha = 0.0;
        weak_self.alertView.alpha = 0.0;
        weak_self.alertView.transform = CGAffineTransformMakeTranslation(weak_self.alertView.bounds.origin.x, endY);
    } completion:^(BOOL finishedm) {
        [weak_self removeFromSuperview];
    }];
}

#pragma mark - get/set

- (UIButton *)backView {
    if (!_backView) {
        _backView = [[UIButton alloc]init];
        _backView.backgroundColor = [UIColor blackColor];
//        [_backView addTarget:self action:@selector(hiddenAnimal) forControlEvents:UIControlEventTouchUpInside];
        _backView.alpha = 0;
    }
    return _backView;
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]init];
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)titleLine {
    if (!_titleLine) {
        _titleLine = [[UIView alloc]init];
        _titleLine.backgroundColor = KUIColorFromHex(0x60c4e9);
    }
    return _titleLine;
}

- (UIView *)contentLine {
    if (!_contentLine) {
        _contentLine = [[UIView alloc]init];
        _contentLine.backgroundColor = KUIColorFromHex(0xe3e3e3);
    }
    return _contentLine;
}

- (UIView *)selectCenterLine {
    if (!_selectCenterLine) {
        _selectCenterLine = [[UIView alloc]init];
        _selectCenterLine.backgroundColor = KUIColorFromHex(0xe3e3e3);
    }
    return _selectCenterLine;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [[UIButton alloc]init];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectButton setTitle:@"确定" forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(selectAct:) forControlEvents:UIControlEventTouchUpInside];
        _selectButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _selectButton;
}

- (UIButton *)unSelectButton {
    if (!_unSelectButton) {
        _unSelectButton = [[UIButton alloc]init];
        [_unSelectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_unSelectButton setTitle:@"取消" forState:UIControlStateNormal];
        [_unSelectButton addTarget:self action:@selector(hiddenAnimal) forControlEvents:UIControlEventTouchUpInside];
        _unSelectButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _unSelectButton;
}

- (UIPickerView *)pickView {
    if (!_pickView) {
        _pickView = [[UIPickerView alloc]init];
        _pickView.showsSelectionIndicator = YES;
        _pickView.delegate = self;
        _pickView.dataSource = self;
    }
    return _pickView;
}


@end
