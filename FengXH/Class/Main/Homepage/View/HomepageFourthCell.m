//
//  HomepageFourthCell.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageFourthCell.h"

@interface HomepageFourthCell()
{
    UILabel *label1;
    UILabel *label2;
    BOOL wichOne;
    int count;
}
@property(nonatomic , strong)NSMutableArray *turnArray;
/** timer */
@property(nonatomic , strong)NSTimer *timer;

@end

@implementation HomepageFourthCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        [self addSubview:self.hotImageView];
        [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.mas_offset(10);
            make.width.mas_equalTo(32);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(self.hotImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        UIImageView *noticeImageView = [[UIImageView alloc] init];
        [noticeImageView setImage:[UIImage imageNamed:@"home_notice"]];
        [noticeImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:noticeImageView];
        [noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(18);
        }];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerRepeat)
                                                userInfo:@"aaaa" repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)setNoticeDataModel:(HomepageDataNoticeDataModel *)noticeDataModel {
    _noticeDataModel = noticeDataModel;
    [self.hotImageView setYy_imageURL:[NSURL URLWithString:_noticeDataModel.iconurl]];
    
    _turnArray = [NSMutableArray array];
    for (NSInteger i=0; i<_noticeDataModel.data.count; i++) {
        HomepageDataNoticeDataDetailsModel *noticeDetailsDataModel = _noticeDataModel.data[i];
        if (noticeDetailsDataModel.title.length > 0) {
            [_turnArray addObject:noticeDetailsDataModel.title];
        }
    }
    count = 1;
    if (_turnArray.count == 0) {
        return;
    }
    for (UIView *subViews in self.contentView.subviews) {
        [subViews removeFromSuperview];
    }
    if (_turnArray.count == 1) {
        label1 = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, self.frame.size.width-100, self.frame.size.height)];
        label1.font = KFont(13);
        label1.textColor = KUIColorFromHex(0x666666);
        label1.text = _turnArray[0];
//        label1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:label1];
    } else {
        label1 = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, self.frame.size.width-100, self.frame.size.height)];
        label1.font = KFont(13);
        label1.textColor = KUIColorFromHex(0x666666);
        label1.text = _turnArray[0];
//        label1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:label1];
        
        label2 = [[UILabel alloc] initWithFrame:CGRectMake(90, self.frame.size.height, self.frame.size.width-100, self.frame.size.height)];
        label2.font = KFont(13);
        label2.textColor = KUIColorFromHex(0x666666);
        label2.text = _turnArray[1];
//        label2.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:label2];
        
    }
    
}


- (void)timerRepeat{
    count++;
    if (count>_turnArray.count-1) {
        count = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        if (!wichOne) {
            label1.frame = CGRectMake(90, -self.frame.size.height, self.frame.size.width-100, self.frame.size.height);
            label2.frame = CGRectMake(90, 0, self.frame.size.width-100, self.frame.size.height);
        }
        if (wichOne) {
            label1.frame = CGRectMake(90, 0, self.frame.size.width-100, self.frame.size.height);
            label2.frame = CGRectMake(90, -self.frame.size.height, self.frame.size.width-100, self.frame.size.height);
        }
    } completion:^(BOOL finished) {
        wichOne = !wichOne;
        if ((int)label1.frame.origin.y==-self.frame.size.height) {
            label1.frame = CGRectMake(90, self.frame.size.height, self.frame.size.width-100, self.frame.size.height);
            label1.text = _turnArray[count];
        }
        if ((int)label2.frame.origin.y==-self.frame.size.height) {
            label2.frame = CGRectMake(90, self.frame.size.height, self.frame.size.width-100, self.frame.size.height);
            label2.text = _turnArray[count];
        }
    }];
    
}


#pragma mark - lazy
- (UIImageView *)hotImageView {
    if (!_hotImageView) {
        _hotImageView = [[UIImageView alloc] init];
        [_hotImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _hotImageView;
}


@end
