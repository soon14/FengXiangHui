//
//  AddressNavigationView.m
//  FengXH
//
//  Created by sun on 2018/9/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AddressNavigationView.h"

@interface AddressNavigationView ()

/** back */
@property(nonatomic , strong)UIButton *backButton;
/** titleLabel */
@property(nonatomic , strong)UILabel *titleLabel;

@end

@implementation AddressNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_offset(0);
            make.width.height.mas_equalTo(44);
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_offset(0);
            make.height.mas_equalTo(44);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.titleLabel setText:_title];
}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(AddressNavigationView:backButtonAction:)]) {
        [self.delegate AddressNavigationView:self backButtonAction:sender];
    }
}


#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"erji_fanhui"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
