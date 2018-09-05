//
//  MyStoreNavigationView.m
//  FengXH
//
//  Created by sun on 2018/8/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyStoreNavigationView.h"

@interface MyStoreNavigationView ()

/** title */
@property(nonatomic , strong)UILabel *titleLabel;

@end


@implementation MyStoreNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.height.mas_equalTo(44);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}


#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setText:@"小店中心"];
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
