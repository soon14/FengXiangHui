//
//  PersonalCellItem.m
//  FengXH
//
//  Created by sun on 2018/7/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalCellItem.h"

@implementation PersonalCellItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.itemImageView];
        [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.height.mas_equalTo(50);
        }];
        
        [self addSubview:self.itemTitleLabel];
        [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-20);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        [self addSubview:self.badgeLabel];
        [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.centerX.mas_equalTo(self.mas_centerX).offset(17);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(26);
        }];
        
    }
    return self;
}

#pragma mark - lazy
- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] init];
        [_badgeLabel setBackgroundColor:KRedColor];
        [_badgeLabel setTextAlignment:NSTextAlignmentCenter];
        [_badgeLabel.layer setMasksToBounds:YES];
        [_badgeLabel.layer setCornerRadius:9];
        [_badgeLabel setText:@""];
        [_badgeLabel setTextColor:[UIColor whiteColor]];
        [_badgeLabel setFont:KFont(11)];
        [_badgeLabel setHidden:YES];
    }
    return _badgeLabel;
}

- (UILabel *)itemTitleLabel {
    if (!_itemTitleLabel) {
        _itemTitleLabel = [[UILabel alloc] init];
        [_itemTitleLabel setTextColor:KUIColorFromHex(0x666666)];
        [_itemTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [_itemTitleLabel setFont:KFont(13)];
    }
    return _itemTitleLabel;
}

- (UIImageView *)itemImageView {
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] init];
    }
    return _itemImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
