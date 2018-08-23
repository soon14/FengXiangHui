//
//  PersonalFirstCell.m
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalFirstCell.h"
#import "PersonalDataModel.h"

@interface PersonalFirstCell ()

/** setting */
@property(nonatomic , strong)UIButton *settingButton;
/** userIcon */
@property(nonatomic , strong)UIImageView *userIcon;
/** userName */
@property(nonatomic , strong)UILabel *userNameLabel;
/** userType */
@property(nonatomic , strong)UILabel *userTypeLabel;
/** Invitation code */
@property(nonatomic , strong)UILabel *invitationCodeLabel;
/** F 币 */
@property(nonatomic , strong)UILabel *coinLabel;
/** 积分 */
@property(nonatomic , strong)UILabel *integralLabel;
/** 充值 */
@property(nonatomic , strong)UIButton *rechargeButton;
/** 兑换 */
@property(nonatomic , strong)UIButton *exchangeButton;

@end

@implementation PersonalFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KTableBackgroundColor;
        UIImageView *backImageView = [[UIImageView alloc] init];
        [backImageView setImage:[UIImage imageNamed:@"personal_firstBack"]];
        [backImageView setContentMode:UIViewContentModeScaleToFill];
        [backImageView setUserInteractionEnabled:YES];
        [self.contentView addSubview:backImageView];
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_offset(0);
        }];
        
        [self.contentView addSubview:self.settingButton];
        [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(-0);
            make.width.height.mas_equalTo(45);
        }];
        
        [self.contentView addSubview:self.userIcon];
        [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(20);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.height.mas_equalTo(56);
        }];
        
        [self.contentView addSubview:self.userNameLabel];
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userIcon.mas_bottom).offset(8);
            make.centerX.mas_equalTo(_userIcon.mas_centerX);
        }];
        
        [self.contentView addSubview:self.userTypeLabel];
        [self.userTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userNameLabel.mas_bottom).offset(5);
            make.centerX.mas_equalTo(_userIcon.mas_centerX);
        }];
        
        [self.contentView addSubview:self.invitationCodeLabel];
        [self.invitationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userTypeLabel.mas_bottom).offset(5);
            make.centerX.mas_equalTo(_userIcon.mas_centerX);
        }];
        
        UILabel *label_1 = [[UILabel alloc] init];
        [label_1 setTextColor:[UIColor whiteColor]];
        [label_1 setFont:KFont(15)];
        [label_1 setTextAlignment:NSTextAlignmentCenter];
        [label_1 setText:@"F币"];
        [self.contentView addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(60);
            make.width.mas_equalTo(50);
            make.left.mas_offset(32);
        }];
        
        [self.contentView addSubview:self.coinLabel];
        [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label_1.mas_bottom).offset(5);
            make.centerX.mas_equalTo(label_1.mas_centerX);
            make.height.mas_equalTo(18);
        }];
        
        [self.contentView addSubview:self.rechargeButton];
        [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_coinLabel.mas_bottom).offset(5);
            make.centerX.mas_equalTo(label_1.mas_centerX);
            make.width.mas_equalTo(54);
            make.height.mas_equalTo(22);
        }];
        
        UILabel *label_2 = [[UILabel alloc] init];
        [label_2 setTextColor:[UIColor whiteColor]];
        [label_2 setFont:KFont(15)];
        [label_2 setTextAlignment:NSTextAlignmentCenter];
        [label_2 setText:@"积分"];
        [self.contentView addSubview:label_2];
        [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(60);
            make.width.mas_equalTo(50);
            make.right.mas_offset(-32);
        }];
        
        [self.contentView addSubview:self.integralLabel];
        [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label_2.mas_bottom).offset(5);
            make.centerX.mas_equalTo(label_2);
            make.height.mas_equalTo(18);
        }];
        
        [self.contentView addSubview:self.exchangeButton];
        [self.exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_integralLabel.mas_bottom).offset(5);
            make.centerX.mas_equalTo(label_2.mas_centerX);
            make.width.mas_equalTo(54);
            make.height.mas_equalTo(22);
        }];
        
    }
    return self;
}


#pragma mark - userIconAction
- (void)userIconAction:(UITapGestureRecognizer *)sender {
    if (self.cellClickBlock) {
        self.cellClickBlock(sender.view.tag);
    }
}

#pragma mark - buttonAction
- (void)cellButtonAction:(UIButton *)sender {
    if (self.cellClickBlock) {
        self.cellClickBlock(sender.tag);
    }
}

- (void)setPersonalDataModel:(PersonalDataModel *)personalDataModel {
    _personalDataModel = personalDataModel;
    [self.userIcon setYy_imageURL:[NSURL URLWithString:_personalDataModel.avatar]];
    [self.userNameLabel setText:_personalDataModel.nickname ? _personalDataModel.nickname : @""];
    [self.userTypeLabel setText:[NSString stringWithFormat:@"[%@]",_personalDataModel.levelname ? _personalDataModel.levelname : @""]];
    [self.invitationCodeLabel setText:[NSString stringWithFormat:@"邀请码：%@",_personalDataModel.userID ? _personalDataModel.userID : @"  "]];
    [self.coinLabel setText:_personalDataModel.credit2 ? _personalDataModel.credit2 : @""];
    [self.integralLabel setText:_personalDataModel.credit1 ? _personalDataModel.credit1 : @""];
}


#pragma mark - lazy
- (UIButton *)exchangeButton {
    if (!_exchangeButton) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeButton setTitle:@"兑换" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exchangeButton.titleLabel setFont:KFont(14)];
        [_exchangeButton.layer setMasksToBounds:YES];
        [_exchangeButton.layer setCornerRadius:11];
        [_exchangeButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_exchangeButton.layer setBorderWidth:1];
        [_exchangeButton setTag:3];
        [_exchangeButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeButton;
}

- (UIButton *)rechargeButton {
    if (!_rechargeButton) {
        _rechargeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
        [_rechargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rechargeButton.titleLabel setFont:KFont(14)];
        [_rechargeButton.layer setMasksToBounds:YES];
        [_rechargeButton.layer setCornerRadius:11];
        [_rechargeButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_rechargeButton.layer setBorderWidth:1];
        [_rechargeButton setTag:2];
        [_rechargeButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeButton;
}

- (UILabel *)integralLabel {
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc] init];
        [_integralLabel setTextColor:KUIColorFromHex(0xfbf456)];
        [_integralLabel setFont:KFont(15)];
        [_integralLabel setTextAlignment:NSTextAlignmentCenter];
        [_integralLabel setText:@"0.00"];
    }
    return _integralLabel;
}

- (UILabel *)coinLabel {
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] init];
        [_coinLabel setTextColor:KUIColorFromHex(0xfbf456)];
        [_coinLabel setFont:KFont(15)];
        [_coinLabel setTextAlignment:NSTextAlignmentCenter];
        [_coinLabel setText:@"0.00"];
    }
    return _coinLabel;
}

- (UILabel *)invitationCodeLabel {
    if (!_invitationCodeLabel) {
        _invitationCodeLabel = [[UILabel alloc] init];
        [_invitationCodeLabel setTextColor:[UIColor whiteColor]];
        [_invitationCodeLabel setFont:KFont(12)];
        [_invitationCodeLabel setTextAlignment:NSTextAlignmentCenter];
        [_invitationCodeLabel setText:@" "];
    }
    return _invitationCodeLabel;
}

- (UILabel *)userTypeLabel {
    if (!_userTypeLabel) {
        _userTypeLabel = [[UILabel alloc] init];
        [_userTypeLabel setTextColor:[UIColor whiteColor]];
        [_userTypeLabel setFont:KFont(12)];
        [_userTypeLabel setTextAlignment:NSTextAlignmentCenter];
        [_userTypeLabel setText:@" "];
    }
    return _userTypeLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        [_userNameLabel setTextColor:[UIColor whiteColor]];
        [_userNameLabel setFont:KFont(15)];
        [_userNameLabel setTextAlignment:NSTextAlignmentCenter];
        [_userNameLabel setText:@" "];
    }
    return _userNameLabel;
}

- (UIImageView *)userIcon {
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] init];
        [_userIcon setBackgroundColor:[UIColor whiteColor]];
        [_userIcon.layer setMasksToBounds:YES];
        [_userIcon.layer setCornerRadius:28];
        [_userIcon setUserInteractionEnabled:YES];
        [_userIcon setTag:0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconAction:)];
        [_userIcon addGestureRecognizer:tap];
    }
    return _userIcon;
}

- (UIButton *)settingButton {
    if (!_settingButton) {
        _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settingButton setImage:[UIImage imageNamed:@"personal_btn_set"] forState:UIControlStateNormal];
        [_settingButton setTag:1];
        [_settingButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingButton;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
