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
    NSMutableArray *stringArr;
    
}
@property(nonatomic , strong)NSTimer *timer;// 定义定时器
@property(nonatomic , strong)UILabel *marqueeLabel;

@end

@implementation HomepageFourthCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.hotImageView];
        [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.mas_offset(10);
            make.width.mas_equalTo(32);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(self.hotImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        UIImageView *noticeImageView = [[UIImageView alloc] init];
        [noticeImageView setImage:[UIImage imageNamed:@"home_notice"]];
        [noticeImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:noticeImageView];
        [noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(18);
        }];
        
        
    }
    return self;
}

- (void)setNoticeDataModel:(HomepageDataNoticeDataModel *)noticeDataModel {
    _noticeDataModel = noticeDataModel;
    [self.hotImageView setYy_imageURL:[NSURL URLWithString:_noticeDataModel.iconurl]];
    [self setUpView];
}

- (void)setUpView {
    [self.contentView addSubview:self.marqueeLabel];
    self.marqueeLabel.sd_layout
    .leftSpaceToView(self, self.frame.size.width - 35)
    .centerYEqualToView(self)
    .heightIs(18);
    [self.marqueeLabel setMaxNumberOfLinesToShow:0];
    
    // 启动NSTimer定时器来改变label的位置
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                  target:self selector:@selector(changePosition)
                                                userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    stringArr = [NSMutableArray array];
    for (NSInteger i=0; i<_noticeDataModel.data.count; i++) {
        HomepageDataNoticeDataDetailsModel *noticeDetailsData = _noticeDataModel.data[i];
        if (noticeDetailsData.title.length > 0) {
            [stringArr addObject:noticeDetailsData.title];
        }
    }
}

static NSInteger arrIndex = 0;
- (void)changePosition {
    CGPoint curPosition = self.marqueeLabel.center;
    // 当curPos的x坐标已经超过了屏幕的宽度
    if(curPosition.y <  - self.marqueeLabel.height/2) {
 
        self.marqueeLabel.center = CGPointMake(self.frame.size.width - self.marqueeLabel.width/2, (20+ self.marqueeLabel.height));
        
        self.marqueeLabel.text = [stringArr objectAtIndex:arrIndex];
        arrIndex ++;
        //循环数组
        if (arrIndex == stringArr.count) {
            arrIndex = 0;
            for (NSInteger i=0; i<_noticeDataModel.data.count; i++) {
                HomepageDataNoticeDataDetailsModel *noticeDetailsData = _noticeDataModel.data[i];
                if (noticeDetailsData.title.length > 0) {
                    [stringArr addObject:noticeDetailsData.title];
                }
            }
            
        }
    } else if((int)curPosition.y == (int)self.marqueeLabel.height){
        self.marqueeLabel.center = CGPointMake(self.frame.size.width - self.marqueeLabel.width/2, curPosition.y - 0.01);
    } else {
        // 通过修改iv的center属性来改变iv控件的位置
        self.marqueeLabel.center = CGPointMake(self.frame.size.width - self.marqueeLabel.width/2, curPosition.y - 0.8);
    }
    //其实label的整个移动都是靠label.center来去设置的
    
}


#pragma mark - lazy
- (UILabel *)marqueeLabel {
    if (!_marqueeLabel) {
        _marqueeLabel = [[UILabel alloc] init];
        _marqueeLabel.font = [UIFont systemFontOfSize:13];
        _marqueeLabel.textColor = KUIColorFromHex(0x666666);
    }
    return _marqueeLabel;
}

- (UIImageView *)hotImageView {
    if (!_hotImageView) {
        _hotImageView = [[UIImageView alloc] init];
        [_hotImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _hotImageView;
}


@end
