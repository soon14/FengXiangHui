//
//  SignInHeaderCollectionReusableView.m
//  FengXH
//
//  Created by sun on 2018/10/9.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "SignInHeaderCollectionReusableView.h"
#import "SignInResultModel.h"

@interface SignInHeaderCollectionReusableView ()

/** 头像 */
@property(nonatomic , strong)UIImageView *userIcon;
/** 昵称 */
@property(nonatomic , strong)UILabel *nickNameLabel;
/** 总签到天数 */
@property(nonatomic , strong)UILabel *totlaSignLabel;
/** 签到按钮 */
@property(nonatomic , strong)UILabel *signInLabel;
/** 连续签到 */
@property(nonatomic , strong)UILabel *continuousSignInLabel;
/** 积分 */
@property(nonatomic , strong)UILabel *creditLabel;
/** k积分商城 */
@property(nonatomic , strong)UIButton *integralButton;
/** 当前年月 */
@property(nonatomic , strong)UILabel *dateLabel;

@end

@implementation SignInHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.userIcon];
        [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(20);
            make.left.mas_offset(15);
            make.width.height.mas_equalTo(50);
        }];
        
        [self addSubview:self.nickNameLabel];
        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_userIcon.mas_right).offset(15);
            make.top.mas_equalTo(_userIcon.mas_top).offset(5);
            make.height.mas_equalTo(22);
        }];
        
        [self addSubview:self.totlaSignLabel];
        [self.totlaSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nickNameLabel.mas_left);
            make.top.mas_equalTo(_nickNameLabel.mas_bottom).offset(3);
        }];
        
        [self addSubview:self.signInLabel];
        [self.signInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_nickNameLabel.mas_centerY);
            make.right.mas_offset(-15);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(26);
        }];
        
        UIView *line_1 = [[UIView alloc] init];
        [line_1 setBackgroundColor:KTableBackgroundColor];
        [self addSubview:line_1];
        [line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(_userIcon.mas_bottom).offset(20);
            make.height.mas_equalTo(5);
        }];
        
        [self addSubview:self.creditLabel];
        [self.creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_userIcon.mas_left);
            make.top.mas_equalTo(line_1.mas_bottom).offset(15);
            make.height.mas_equalTo(26);
        }];
        
        [self addSubview:self.continuousSignInLabel];
        [self.continuousSignInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_signInLabel.mas_right);
            make.top.mas_equalTo(_signInLabel.mas_bottom).offset(8);
        }];
        
        UILabel *label_1 = [[UILabel alloc] init];
        [label_1 setTextColor:KUIColorFromHex(0x999999)];
        [label_1 setFont:KFont(12)];
        [label_1 setText:@"您的积分"];
        [self addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_creditLabel.mas_left);
            make.top.mas_equalTo(_creditLabel.mas_bottom);
            make.height.mas_equalTo(15);
        }];
        
        [self addSubview:self.integralButton];
        [self.integralButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_signInLabel.mas_right);
            make.top.mas_equalTo(line_1.mas_bottom).offset(25);
            make.width.width.mas_equalTo(80);
            make.height.mas_equalTo(26);
        }];
        
        UIView *line_2 = [[UIView alloc] init];
        [line_2 setBackgroundColor:KTableBackgroundColor];
        [self addSubview:line_2];
        [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(label_1.mas_bottom).offset(15);
            make.height.mas_equalTo(5);
        }];
        
        NSArray *titleArr = @[@"天",@"一",@"二",@"三",@"四",@"五",@"六"];
        for (NSInteger i=0; i<7; i++) {
            UILabel *label = [[UILabel alloc] init];
            [label setTextColor:KUIColorFromHex(0x999999)];
            [label setFont:[UIFont systemFontOfSize:14]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setText:titleArr[i]];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset((KMAINSIZE.width/7)*i);
                make.bottom.mas_offset(0);
                make.width.mas_equalTo(KMAINSIZE.width/7);
                make.height.mas_equalTo(30);
            }];
        }
        
        [self addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-30);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(30);
        }];
        
    }
    return self;
}

- (void)setHeaderResultModel:(SignInResultModel *)headerResultModel {
    _headerResultModel = headerResultModel;
    [self.userIcon setYy_imageURL:[NSURL URLWithString:_headerResultModel.member.avatar]];
    [self.nickNameLabel setText:_headerResultModel.member.nickname];
    [self.totlaSignLabel setText:[NSString stringWithFormat:@"您已签到%ld天",(long)_headerResultModel.sum]];
    if (_headerResultModel.haveSigned) {
        [self.signInLabel setText:@"今日已签"];
    } else {
        [self.signInLabel setText:@"点击签到"];
    }
    [self.creditLabel setText:[NSString stringWithFormat:@"%ld",(long)_headerResultModel.member.credit1]];
    [self.continuousSignInLabel setText:[NSString stringWithFormat:@"您已连续签到%ld天",(long)_headerResultModel.orderday]];
    [self.dateLabel setText:[ShareManager getNowTimeYearMonthstamp]];
}



#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.signInHeaderBlock) {
        self.signInHeaderBlock(sender.tag);
    }
}

#pragma mark - gestureAction
- (void)gestureAction:(UITapGestureRecognizer *)sender {
    if (!_headerResultModel.haveSigned) {
        if (self.signInHeaderBlock) {
            self.signInHeaderBlock(sender.view.tag);
        }
    }
}

#pragma mark - lazy
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        [_dateLabel setTextColor:KUIColorFromHex(0x999999)];
        [_dateLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _dateLabel;
}

- (UIButton *)integralButton {
    if (!_integralButton) {
        _integralButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_integralButton setBackgroundColor:KTableBackgroundColor];
        [_integralButton setTitle:@"积分商城" forState:UIControlStateNormal];
        [_integralButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_integralButton.titleLabel setFont:KFont(13)];
        [_integralButton.layer setMasksToBounds:YES];
        [_integralButton.layer setCornerRadius:13];
        [_integralButton setTag:1];
        [_integralButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _integralButton;
}

- (UILabel *)continuousSignInLabel {
    if (!_continuousSignInLabel) {
        _continuousSignInLabel = [[UILabel alloc] init];
        [_continuousSignInLabel setTextColor:KUIColorFromHex(0x999999)];
        [_continuousSignInLabel setFont:KFont(12)];
        [_continuousSignInLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _continuousSignInLabel;
}

- (UILabel *)creditLabel {
    if (!_creditLabel) {
        _creditLabel = [[UILabel alloc] init];
        [_creditLabel setTextColor:KUIColorFromHex(0x333333)];
        [_creditLabel setFont:KFont(24)];
    }
    return _creditLabel;
}

- (UILabel *)signInLabel {
    if (!_signInLabel) {
        _signInLabel = [[UILabel alloc] init];
        [_signInLabel setTextColor:[UIColor whiteColor]];
        [_signInLabel setFont:KFont(13)];
        [_signInLabel setTextAlignment:NSTextAlignmentCenter];
        [_signInLabel.layer addSublayer:[self backgroundLayer]];
        [_signInLabel setUserInteractionEnabled:YES];
        [_signInLabel setTag:0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
        [_signInLabel addGestureRecognizer:tap];
    }
    return _signInLabel;
}

- (CAGradientLayer *)backgroundLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 80, 26);
    gradientLayer.colors = @[(__bridge id)KUIColorFromHex(0xfc3030).CGColor,(__bridge id)KUIColorFromHex(0xf08d66).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.cornerRadius = 13;
    return gradientLayer;
}

- (UILabel *)totlaSignLabel {
    if (!_totlaSignLabel) {
        _totlaSignLabel = [[UILabel alloc] init];
        [_totlaSignLabel setTextColor:KUIColorFromHex(0x999999)];
        [_totlaSignLabel setFont:KFont(12)];
    }
    return _totlaSignLabel;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] init];
        [_nickNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_nickNameLabel setFont:KFont(20)];
    }
    return _nickNameLabel;
}

- (UIImageView *)userIcon {
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] init];
        [_userIcon.layer setMasksToBounds:YES];
        [_userIcon.layer setCornerRadius:25];
    }
    return _userIcon;
}


@end
