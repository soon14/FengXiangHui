//
//  PayOrderMethodItem.m
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PayOrderMethodItem.h"

@implementation PayOrderMethodItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(30);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconView.mas_right).offset(10);
            make.top.mas_offset(15);
            make.bottom.mas_offset(-15);
            make.width.mas_equalTo(0.5);
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(line.mas_right).offset(10);
            make.bottom.mas_equalTo(self.mas_centerY).offset(-3);
        }];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [imageV setImage:[UIImage imageNamed:@"pay_secury"]];
        [self addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel.mas_left);
            make.top.mas_equalTo(self.mas_centerY).offset(5);
        }];
        
        [self addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageV.mas_right).offset(2);
            make.centerY.mas_equalTo(imageV.mas_centerY);
        }];
        
        UIImageView *arrow = [[UIImageView alloc] init];
        [arrow setImage:[UIImage imageNamed:@"home_icon_arrow"]];
        [self addSubview:arrow];
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}


- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setTextColor:KUIColorFromHex(0x333333)];
        [_detailLabel setFont:KFont(11)];
    }
    return _detailLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_titleLabel setFont:KFont(14)];
    }
    return _titleLabel;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        [_iconView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _iconView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
