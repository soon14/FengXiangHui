//
//  SigninDayCollectionViewCell.m
//  SignIn_demo
//
//  Created by sun on 2018/9/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SignInDayCollectionViewCell.h"
#import "ShareManager.h"
#import "SignInResultModel.h"

@interface SignInDayCollectionViewCell ()

/** 已经签到的背景 */
@property(nonatomic , strong)UIView *signedBackView;
/** label */
@property(nonatomic , strong)UILabel *dayLabel;

@end

@implementation SignInDayCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.signedBackView];
        [self.signedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(40);
        }];
        
        [self.contentView addSubview:self.dayLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setDateString:(NSString *)dateString {
    _dateString = dateString;
    if ([_dateString integerValue] > 0 && [_dateString integerValue] <= [ShareManager convertDateToTotalDays:[NSDate date]]) {
        [self.dayLabel setText:_dateString];
    } else {
        [self.dayLabel setText:@""];
    }
}

- (void)setSignedArray:(NSArray *)signedArray {
    _signedArray = signedArray;
    for (SignInResultCalendarModel *calendarModel in _signedArray) {
        if (calendarModel.day == [_dateString integerValue]) {
            [self.signedBackView setHidden:NO];
            break;
        } else {
            [self.signedBackView setHidden:YES];
        }
    }
}

#pragma mark - gestureAction
- (void)gestureAction:(UITapGestureRecognizer *)sender {
    if ([_dateString integerValue] > 0 && [_dateString integerValue] <= [ShareManager convertDateToTotalDays:[NSDate date]] && self.signedBackView.hidden == YES) {
        if (self.signInDayBlock) {
            self.signInDayBlock(_dateString);
        }
    }
}


#pragma mark - lazy
- (UIView *)signedBackView {
    if (!_signedBackView) {
        _signedBackView = [[UIView alloc] init];
        [_signedBackView setBackgroundColor:KUIColorFromHex(0xFEE5E5)];
        [_signedBackView.layer setMasksToBounds:YES];
        [_signedBackView.layer setCornerRadius:20];
        [_signedBackView setHidden:YES];
    }
    return _signedBackView;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_dayLabel setTextColor:[UIColor darkGrayColor]];
        [_dayLabel setFont:[UIFont systemFontOfSize:14]];
        [_dayLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _dayLabel;
}


@end
