//
//  KillTableViewHeaderView.m
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "KillTableViewHeaderView.h"

@interface KillTableViewHeaderView()

@property (nonatomic ,strong) UILabel *timeLabel;
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
        [self.topView.layer addSublayer:[self backgroundLayer]];
        
        [self.topView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_offset(0);
            make.width.mas_equalTo(80);
        }];
        
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.top.mas_equalTo(_topView.mas_bottom);
            make.bottom.mas_offset(0);
        }];
        
        [self addSubview:self.countdownLabel];
        [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_topView.mas_bottom);
            make.bottom.mas_offset(0);
            make.right.mas_offset(-100);
        }];
        
        
    }
    return self;
}

#pragma mark - lazy
- (CAGradientLayer *)backgroundLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 80, 52);
    gradientLayer.colors = @[(__bridge id)KUIColorFromHex(0xfc3030).CGColor,(__bridge id)KUIColorFromHex(0xf08d66).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    return gradientLayer;
}

- (UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [_timeLabel setTextColor:[UIColor whiteColor]];
        [_timeLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [_timeLabel setNumberOfLines:2];
    }
    return _timeLabel;
}
- (UILabel *)countdownLabel{
    if(!_countdownLabel){
        _countdownLabel = [[UILabel alloc]init];
        _countdownLabel.text = @"距结束";
        _countdownLabel.textAlignment = NSTextAlignmentRight;
        [_countdownLabel setFont:KFont(14)];
        [_countdownLabel setTextColor:KUIColorFromHex(0x666666)];
    }
    return _countdownLabel;
}
- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"抢购中，先下先得！";
        [_titleLabel setFont:KFont(15)];
        [_titleLabel setTextColor:KUIColorFromHex(0x666666)];
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
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:00\n抢购中",data]];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(attributedString.length-3, 3)];
    [self.timeLabel setAttributedText:attributedString];
    
}
@end
