//
//  HomepageSixthCell.m
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageSixthCell.h"

@implementation HomepageSixthCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.countDownLabel];
        [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(40);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self.contentView addSubview:self.moreButton];
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return self;
}

#pragma mark - 更多按钮点击
- (void)moreButtonAction:(UIButton *)sender {
    if (self.sixthCellBlock) {
        self.sixthCellBlock(sender.tag);
    }
}

#pragma mark - lazy
- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [_moreButton.titleLabel setFont:KFont(14)];
        [_moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UILabel *)countDownLabel {
    if (!_countDownLabel) {
        _countDownLabel = [[UILabel alloc] init];
        [_countDownLabel setTextColor:KUIColorFromHex(0x333333)];
        [_countDownLabel setFont:KFont(14)];
        [_countDownLabel setText:@"0点场"];
    }
    return _countDownLabel;
}


@end
