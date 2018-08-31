//
//  MyStoreCustomCellItem.m
//  FengXH
//
//  Created by sun on 2018/8/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyStoreCustomCellItem.h"

@implementation MyStoreCustomCellItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_centerY).offset(-5);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_icon.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [self addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(5);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
    }
    return self;
}

#pragma mark - lazy
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_titleLabel setFont:KFont(14)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setTextColor:KUIColorFromHex(0x333333)];
        [_detailLabel setFont:KFont(14)];
        [_detailLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _detailLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
