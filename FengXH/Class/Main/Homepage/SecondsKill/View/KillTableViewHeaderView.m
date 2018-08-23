//
//  KillTableViewHeaderView.m
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "KillTableViewHeaderView.h"
#import "M80AttributedLabel.h"

@interface KillTableViewHeaderView()

@property (nonatomic ,strong) M80AttributedLabel *timeLabel;
@property (nonatomic ,strong) UILabel *countdownLabel;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIView *topView;

@end


@implementation KillTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KTableBackgroundColor;
        
        [self addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            
            make.height.mas_equalTo(52);
        }];
        
        [self.topView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.topView).mas_offset(5);
            
            make.width.mas_equalTo(80);
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5);
            make.bottom.mas_offset(-5);
            make.top.mas_offset(55);
//            make.right.mas_offset(-200);
        }];
        [self addSubview:self.countdownLabel];
        [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.titleLabel.mas_right).offset(20);
            make.bottom.mas_offset(-5);
            make.top.mas_offset(55);
            make.right.mas_offset(-100);
        }];
        
        
    }
    return self;
}

- (M80AttributedLabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[M80AttributedLabel alloc]init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.lineSpacing = 3;
        _timeLabel.textAlignment = kCTTextAlignmentCenter;

    }
    
    return _timeLabel;
}
- (UILabel *)countdownLabel{
    if(!_countdownLabel){
        _countdownLabel = [[UILabel alloc]init];
        _countdownLabel.text = @"距结束";
        _countdownLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countdownLabel;
}
- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"抢购中 先下单先得哦";
    }
    return _titleLabel;
}
- (UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (void)setdata:(NSString *)data{
    [_timeLabel setAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:00",data] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:KUIColorFromHex(0xff463c)}]];
    
    [_timeLabel appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n 抢购中"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:KUIColorFromHex(0xff463c)}]];
}
@end
