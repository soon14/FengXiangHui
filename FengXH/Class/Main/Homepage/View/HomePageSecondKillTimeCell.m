//
//  HomePageSecondKillCell.m
//  FengXH
//
//  Created by 孙湖滨 on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomePageSecondKillTimeCell.h"
#import "HomepageDataModel.h"

@interface HomePageSecondKillTimeCell ()
{
    /** timer */
    dispatch_source_t _timer;
}
/** day */
@property(nonatomic , copy)NSString *dayString;
/** hour */
@property(nonatomic , copy)NSString *hourString;
/** min */
@property(nonatomic , copy)NSString *minuteString;
/** sec */
@property(nonatomic , copy)NSString *secondString;
/** 倒计时图片 */
@property(nonatomic , strong)UIImageView *timeImageView;
/** 倒计时 */
@property(nonatomic , strong)UILabel *countDownLabel;
/** 更多按钮 */
@property(nonatomic , strong)UIButton *moreButton;

@end

@implementation HomePageSecondKillTimeCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.timeImageView];
        [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(16);
        }];
        
        [self.contentView addSubview:self.countDownLabel];
        [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self.contentView addSubview:self.moreButton];
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(45);
        }];
        
    }
    return self;
}

#pragma mark - 更多按钮点击
- (void)moreButtonAction:(UIButton *)sender {
//    if (self.sixthCellBlock) {
//        self.sixthCellBlock(sender.tag);
//    }
//    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageFunctionCell:didSelectFunctiomItemWith:)]) {
//        [self.delegate HomePageFunctionCell:self didSelectFunctiomItemWith:menuDateModel];
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageSecondKillTimeCell:didClickMoreButton:)]) {
        [self.delegate HomePageSecondKillTimeCell:self didClickMoreButton:self.secondKillModel];
    }
}

- (void)setSecondKillModel:(HomepageDataSecondKillModel *)secondKillModel {
    _secondKillModel = secondKillModel;
    [self.timeImageView setYy_imageURL:[NSURL URLWithString:_secondKillModel.data.iconurl]];
    
    CGFloat nowTimeStmp = [[ShareManager getNowTimeTimestamp] doubleValue];
    if (nowTimeStmp <= [_secondKillModel.data.starttime doubleValue]) {
        [self downSecondHandle:_secondKillModel.data.starttime];
    } else if (nowTimeStmp > [_secondKillModel.data.starttime doubleValue] && nowTimeStmp < [_secondKillModel.data.endtime doubleValue]) {
        [self downSecondHandle:_secondKillModel.data.endtime];
    }
}

- (void)downSecondHandle:(NSString *)aTimeString {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [dateFormatter dateFromString:[self timeWithTimeIntervalString:aTimeString]]; //结束时间
    NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate])];
    NSDate *startDate = [NSDate date];
    NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
    
    if (_timer==nil) {
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            MJWeakSelf
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.countDownLabel setText:[NSString stringWithFormat:@"%@点场  距结束 00:00:00",_secondKillModel.data.time]];
                    });
                } else {
                    int days = (int)(timeout/(3600*24));
                    if (days==0) {
                        self.dayString = @"";
                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days==0) {
                            self.dayString = @"";
                        } else {
                            self.dayString = [NSString stringWithFormat:@"%d天",days];
                        }
                        if (hours<10) {
                            self.hourString = [NSString stringWithFormat:@"0%d",hours];
                        } else {
                            self.hourString = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            self.minuteString = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            self.minuteString = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            self.secondString = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondString = [NSString stringWithFormat:@"%d",second];
                        }
                        
                        CGFloat nowTimeStmp = [[ShareManager getNowTimeTimestamp] doubleValue];
                        if (nowTimeStmp <= [_secondKillModel.data.starttime doubleValue]) {
                            //                            NSLog(@"%.lf",nowTimeStmp);
                            [weakSelf.countDownLabel setText:[NSString stringWithFormat:@"%@点场  距开始 %@:%@:%@",_secondKillModel.data.time,_hourString,_minuteString,_secondString]];
                        } else if (nowTimeStmp > [_secondKillModel.data.starttime doubleValue] && nowTimeStmp < [_secondKillModel.data.endtime doubleValue]) {
                            //                            NSLog(@"%.lf",nowTimeStmp);
                            [weakSelf.countDownLabel setText:[NSString stringWithFormat:@"%@点场  距结束 %@:%@:%@",_secondKillModel.data.time,_hourString,_minuteString,_secondString]];
                        }
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

//时间戳转换为日期格式(毫秒的时间戳)
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString {
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

#pragma mark - lazy
- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"home_icon_arrow"] forState:UIControlStateNormal];
        [_moreButton setTintColor:KUIColorFromHex(0x333333)];
        [_moreButton.titleLabel setFont:KFont(14)];
        [_moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, -30)];
        [_moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        [_moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UILabel *)countDownLabel {
    if (!_countDownLabel) {
        _countDownLabel = [[UILabel alloc] init];
        [_countDownLabel setTextColor:KUIColorFromHex(0x333333)];
        [_countDownLabel setFont:KFont(14)];
        //        [_countDownLabel setText:@"0点场"];
    }
    return _countDownLabel;
}

- (UIImageView *)timeImageView {
    if (!_timeImageView) {
        _timeImageView = [[UIImageView alloc] init];
        //        [_timeImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _timeImageView;
}

@end
