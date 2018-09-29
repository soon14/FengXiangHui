//
//  IntegralBaseHeaderView.m
//  FengXH
//
//  Created by sun on 2018/9/26.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralBaseHeaderView.h"
#import "PersonalDataModel.h"

@interface IntegralBaseHeaderView ()

/** 头像 */
@property(nonatomic , strong)UIImageView *userIcon;
/** 昵称 */
@property(nonatomic , strong)UILabel *userNameLabel;
/** 店主 */
@property(nonatomic , strong)UIImageView *shopkeeper;
/** 积分 */
@property(nonatomic , strong)UILabel *integralLabel;

@end

@implementation IntegralBaseHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGFloat ButtonHeight = 42;
        CGFloat ButtonWidth = KMAINSIZE.width/3;
        
        [self addSubview:self.integralMallButton];
        [self.integralMallButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_offset(0);
            make.width.mas_equalTo(ButtonWidth);
            make.height.mas_equalTo(ButtonHeight);
        }];
        
        [self addSubview:self.integralExchangeButton];
        [self.integralExchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(ButtonWidth);
            make.bottom.mas_offset(0);
            make.width.mas_equalTo(ButtonWidth);
            make.height.mas_equalTo(ButtonHeight);
        }];
        
        [self addSubview:self.exchangeRecordButton];
        [self.exchangeRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_offset(0);
            make.width.mas_equalTo(ButtonWidth);
            make.height.mas_equalTo(ButtonHeight);
        }];
        
        UIView *line_1 = [[UIView alloc] init];
        [line_1 setBackgroundColor:KLineColor];
        [self addSubview:line_1];
        [line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_integralMallButton.mas_right);
            make.centerY.mas_equalTo(_integralMallButton.mas_centerY);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(25);
        }];
        
        UIView *line_2 = [[UIView alloc] init];
        [line_2 setBackgroundColor:KLineColor];
        [self addSubview:line_2];
        [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_integralExchangeButton.mas_right);
            make.centerY.mas_equalTo(_integralMallButton.mas_centerY);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(25);
        }];
        
        UIView *line_3 = [[UIView alloc] init];
        [line_3 setBackgroundColor:KLineColor];
        [self addSubview:line_3];
        [line_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
        
        UIImageView *backImageView = [[UIImageView alloc] init];
        [backImageView setImage:[UIImage imageNamed:@"integralHeader"]];
        [backImageView setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:backImageView];
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.bottom.mas_equalTo(_integralMallButton.mas_top);
        }];
        
        [backImageView addSubview:self.userIcon];
        [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-15);
            make.left.mas_offset(20);
            make.width.height.mas_equalTo(50);
        }];
        
        [backImageView addSubview:self.userNameLabel];
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_userIcon.mas_right).offset(15);
            make.bottom.mas_equalTo(_userIcon.mas_centerY);
        }];
        
        [backImageView addSubview:self.shopkeeper];
        [self.shopkeeper mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_userNameLabel.mas_left);
            make.top.mas_equalTo(_userNameLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(15);
        }];
        
        [backImageView addSubview:self.integralLabel];
        [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_userNameLabel.mas_bottom);
            make.right.mas_offset(-20);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:KFont(12)];
        [label setText:@"积分"];
        [backImageView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_integralLabel.mas_right);
            make.centerY.mas_equalTo(_shopkeeper.mas_centerY);
        }];
        
        
    }
    return self;
}

- (void)setPersonalDataModel:(PersonalDataModel *)personalDataModel {
    _personalDataModel = personalDataModel;
    [self.userIcon setYy_imageURL:[NSURL URLWithString:_personalDataModel.avatar]];
    [self.userNameLabel setText:_personalDataModel.nickname];
    if ([_personalDataModel.levelname isEqualToString:@"店主"]) {
        [self.shopkeeper setHidden:NO];
    } else {
        [self.shopkeeper setHidden:YES];
    }
    [self.integralLabel setText:[NSString stringWithFormat:@"%ld",(long)[_personalDataModel.credit1 integerValue]]];

}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.headerBlock) {
        self.headerBlock(sender.tag);
    }
}

#pragma mark - lazy

- (UILabel *)integralLabel {
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc] init];
        [_integralLabel setTextColor:[UIColor whiteColor]];
        [_integralLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    return _integralLabel;
}

- (UIImageView *)shopkeeper {
    if (!_shopkeeper) {
        _shopkeeper = [[UIImageView alloc] init];
        [_shopkeeper setImage:[UIImage imageNamed:@"integralShopkeeper"]];
        [_shopkeeper setHidden:YES];
    }
    return _shopkeeper;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        [_userNameLabel setTextColor:[UIColor whiteColor]];
        [_userNameLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    return _userNameLabel;
}

- (UIImageView *)userIcon {
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] init];
        [_userIcon setBackgroundColor:KTableBackgroundColor];
        [_userIcon.layer setMasksToBounds:YES];
        [_userIcon.layer setCornerRadius:25];
    }
    return _userIcon;
}

- (UIButton *)exchangeRecordButton {
    if (!_exchangeRecordButton) {
        _exchangeRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeRecordButton setBackgroundColor:[UIColor whiteColor]];
        [_exchangeRecordButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_exchangeRecordButton setTitle:@"兑换记录" forState:UIControlStateNormal];
        [_exchangeRecordButton.titleLabel setFont:KFont(15)];
        [_exchangeRecordButton setTag:2];
        [_exchangeRecordButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeRecordButton;
}

- (UIButton *)integralExchangeButton {
    if (!_integralExchangeButton) {
        _integralExchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_integralExchangeButton setBackgroundColor:[UIColor whiteColor]];
        [_integralExchangeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_integralExchangeButton setTitle:@"积分兑换" forState:UIControlStateNormal];
        [_integralExchangeButton.titleLabel setFont:KFont(15)];
        [_integralExchangeButton setTag:1];
        [_integralExchangeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _integralExchangeButton;
}

- (UIButton *)integralMallButton {
    if (!_integralMallButton) {
        _integralMallButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_integralMallButton setBackgroundColor:[UIColor whiteColor]];
        [_integralMallButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_integralMallButton setTitle:@"积分商城" forState:UIControlStateNormal];
        [_integralMallButton.titleLabel setFont:KFont(15)];
        [_integralMallButton setTag:0];
        [_integralMallButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _integralMallButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
