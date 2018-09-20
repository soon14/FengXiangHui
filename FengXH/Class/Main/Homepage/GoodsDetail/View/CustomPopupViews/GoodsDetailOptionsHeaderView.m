//
//  GoodsDetailOptionsReusableView.m
//  FengXH
//
//  Created by sun on 2018/9/20.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailOptionsHeaderView.h"

@interface GoodsDetailOptionsHeaderView ()

/** titleLabel */
@property(nonatomic , strong)UILabel *titleLabel;

@end

@implementation GoodsDetailOptionsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return self;
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:KUIColorFromHex(0x666666)];
        [_titleLabel setFont:KFont(14)];
        [_titleLabel setText:@"规格"];
    }
    return _titleLabel;
}

@end

