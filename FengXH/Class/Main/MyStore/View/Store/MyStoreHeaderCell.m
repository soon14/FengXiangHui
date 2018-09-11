//
//  MyStoreHeaderCell.m
//  FengXH
//
//  Created by sun on 2018/8/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyStoreHeaderCell.h"
#import "MyStoreResultModel.h"

@interface MyStoreHeaderCell ()

/** backImageView */
@property(nonatomic , strong)UIImageView *backImageView;
/** backView */
@property(nonatomic , strong)BaseCornerShadowView *infoBackView;
/** 头像 */
@property(nonatomic , strong)UIImageView *userIcon;
/** 用户名 */
@property(nonatomic , strong)UILabel *userNameLabel;
/** 推荐人 */
@property(nonatomic , strong)UILabel *recommendNameLabel;
/** 推荐号码 */
@property(nonatomic , strong)UILabel *recommendNumLabel;
/** 邀请码 */
@property(nonatomic , strong)UILabel *invitationCodeLabel;
/** 提现 */
@property(nonatomic , strong)UIButton *withdrawButton;
/** 成功提取 */
@property(nonatomic , strong)UILabel *withdrawSuccessLabel;
/** 可提取 */
@property(nonatomic , strong)UILabel *ableWithdrawLabel;

@end

@implementation MyStoreHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.backImageView];
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo([ShareManager getImageHeight:@"MyToreHeader"]);
        }];
        
        [self addSubview:self.infoBackView];
        [self.infoBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_backImageView.mas_bottom).offset(-20);
            make.left.mas_offset(16);
            make.right.mas_offset(-16);
            make.height.mas_equalTo(185);
        }];
        
        [self.infoBackView addSubview:self.userIcon];
        [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.top.mas_offset(20);
            make.width.height.mas_offset(52);
        }];
        
        [self.infoBackView addSubview:self.userNameLabel];
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userIcon.mas_top);
            make.left.mas_equalTo(_userIcon.mas_right).offset(20);
        }];
        
        UIImageView *shopkeeperImageV = [[UIImageView alloc] init];
        [shopkeeperImageV setImage:[UIImage imageNamed:@"shopowner"]];
        [self.infoBackView addSubview:shopkeeperImageV];
        [shopkeeperImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_userNameLabel.mas_right).offset(5);
            make.centerY.mas_equalTo(_userNameLabel.mas_centerY);
        }];
        
        [self.infoBackView addSubview:self.recommendNameLabel];
        [self.recommendNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userNameLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(_userNameLabel.mas_left);
        }];
        
        [self.infoBackView addSubview:self.recommendNumLabel];
        [self.recommendNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_recommendNameLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(_userNameLabel.mas_left);
        }];
        
        [self.infoBackView addSubview:self.invitationCodeLabel];
        [self.invitationCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_recommendNumLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(_userNameLabel.mas_left);
        }];
        
        [self.infoBackView addSubview:self.withdrawButton];
        [self.withdrawButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(50);
            make.right.mas_offset(-20);
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(20);
        }];
        
        UIView *line_1 = [[UIView alloc] init];
        [line_1 setBackgroundColor:KLineColor];
        [self.infoBackView addSubview:line_1];
        [line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_invitationCodeLabel.mas_bottom).offset(10);
            make.left.mas_offset(20);
            make.right.mas_offset(-20);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *line_2 = [[UIView alloc] init];
        [line_2 setBackgroundColor:KLineColor];
        [self.infoBackView addSubview:line_2];
        [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line_1.mas_bottom);
            make.centerX.mas_equalTo(_infoBackView.mas_centerX);
            make.bottom.mas_offset(-20);
            make.width.mas_equalTo(0.5);
        }];
        
        UILabel *label_1 = [[UILabel alloc] init];
        [label_1 setTextColor:KUIColorFromHex(0x333333)];
        [label_1 setFont:KFont(13)];
        [label_1 setText:@"成功提取佣金(元)"];
        [label_1 setTextAlignment:NSTextAlignmentRight];
        [self.infoBackView addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line_1.mas_bottom).offset(10);
            make.right.mas_equalTo(line_2.mas_left).offset(-20);
        }];
        
        UIImageView *imageV_1 = [[UIImageView alloc] init];
        [imageV_1 setImage:[UIImage imageNamed:@"commission"]];
        [self.infoBackView addSubview:imageV_1];
        [imageV_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(label_1.mas_left).offset(-10);
            make.centerY.mas_equalTo(label_1.mas_centerY);
        }];
        
        UIImageView *imageV_2 = [[UIImageView alloc] init];
        [imageV_2 setImage:[UIImage imageNamed:@"commission"]];
        [self.infoBackView addSubview:imageV_2];
        [imageV_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(label_1.mas_centerY);
            make.left.mas_equalTo(line_2.mas_right).offset(20);
        }];
        
        UILabel *label_2 = [[UILabel alloc] init];
        [label_2 setTextColor:KUIColorFromHex(0x333333)];
        [label_2 setFont:KFont(13)];
        [label_2 setText:@"可提现佣金(元)"];
        [self.infoBackView addSubview:label_2];
        [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(label_1.mas_centerY);
            make.left.mas_equalTo(imageV_2.mas_right).offset(10);
        }];
        
        [self.infoBackView addSubview:self.withdrawSuccessLabel];
        [self.withdrawSuccessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label_1.mas_bottom).offset(11);
            make.left.mas_equalTo(imageV_1.mas_left);
        }];
        
        [self.infoBackView addSubview:self.ableWithdrawLabel];
        [self.ableWithdrawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_withdrawSuccessLabel.mas_top);
            make.left.mas_equalTo(imageV_2.mas_left);
        }];
        
    }
    return self;
}

#pragma mark - 提现
- (void)withdrawButtonAction:(UIButton *)sender {
    if (self.withdrawBlock) {
        self.withdrawBlock(sender);
    }
}

- (void)setResultModel:(MyStoreResultModel *)resultModel {
    _resultModel = resultModel;
    [self.userIcon setYy_imageURL:[NSURL URLWithString:_resultModel.avatar]];
    [self.userNameLabel setText:_resultModel.nickname];
    [self.recommendNameLabel setText:[NSString stringWithFormat:@"推荐人：%@",_resultModel.upmember?_resultModel.upmember:@""]];
    [self.recommendNumLabel setText:[NSString stringWithFormat:@"推荐人电话：%@",_resultModel.umobile?_resultModel.umobile:@""]];
    [self.invitationCodeLabel setText:[NSString stringWithFormat:@"邀请码：%@",_resultModel.mid]];
    [self.withdrawSuccessLabel setText:_resultModel.successwithdraw?_resultModel.successwithdraw:@""];
    [self.ableWithdrawLabel setText:_resultModel.canwithdraw?_resultModel.canwithdraw:@""];
}

#pragma mark - lazy
- (UILabel *)ableWithdrawLabel {
    if (!_ableWithdrawLabel) {
        _ableWithdrawLabel = [[UILabel alloc] init];
        [_ableWithdrawLabel setTextColor:KUIColorFromHex(0x999999)];
        [_ableWithdrawLabel setFont:KFont(24)];
//        [_ableWithdrawLabel setText:@"0009"];
    }
    return _ableWithdrawLabel;
}

- (UILabel *)withdrawSuccessLabel {
    if (!_withdrawSuccessLabel) {
        _withdrawSuccessLabel = [[UILabel alloc] init];
        [_withdrawSuccessLabel setTextColor:KUIColorFromHex(0x999999)];
        [_withdrawSuccessLabel setFont:KFont(24)];
//        [_withdrawSuccessLabel setText:@"0.43"];
    }
    return _withdrawSuccessLabel;
}

- (UIButton *)withdrawButton {
    if (!_withdrawButton) {
        _withdrawButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_withdrawButton setBackgroundColor:KRedColor];
        [_withdrawButton setTitle:@"提取佣金" forState:UIControlStateNormal];
        [_withdrawButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_withdrawButton.titleLabel setFont:KFont(12)];
        [_withdrawButton.layer setMasksToBounds:YES];
        [_withdrawButton.layer setCornerRadius:10];
        [_withdrawButton addTarget:self action:@selector(withdrawButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withdrawButton;
}

- (UILabel *)invitationCodeLabel {
    if (!_invitationCodeLabel) {
        _invitationCodeLabel = [[UILabel alloc] init];
        [_invitationCodeLabel setTextColor:KUIColorFromHex(0x999999)];
        [_invitationCodeLabel setFont:KFont(10)];
//        [_invitationCodeLabel setText:@"宴请吗"];
    }
    return _invitationCodeLabel;
}

- (UILabel *)recommendNumLabel {
    if (!_recommendNumLabel) {
        _recommendNumLabel = [[UILabel alloc] init];
        [_recommendNumLabel setTextColor:KUIColorFromHex(0x999999)];
        [_recommendNumLabel setFont:KFont(10)];
//        [_recommendNumLabel setText:@"推荐号码"];
    }
    return _recommendNumLabel;
}

- (UILabel *)recommendNameLabel {
    if (!_recommendNameLabel) {
        _recommendNameLabel = [[UILabel alloc] init];
        [_recommendNameLabel setTextColor:KUIColorFromHex(0x999999)];
        [_recommendNameLabel setFont:KFont(10)];
//        [_recommendNameLabel setText:@"对对对"];
    }
    return _recommendNameLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        [_userNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_userNameLabel setFont:KFont(17)];
//        [_userNameLabel setText:@" "];
    }
    return _userNameLabel;
}

- (UIImageView *)userIcon {
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] init];
//        [_userIcon setBackgroundColor:KTableBackgroundColor];
        [_userIcon.layer setMasksToBounds:YES];
        [_userIcon.layer setCornerRadius:26];
    }
    return _userIcon;
}

- (BaseCornerShadowView *)infoBackView {
    if (!_infoBackView) {
        _infoBackView = [[BaseCornerShadowView alloc] init];
    }
    return _infoBackView;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        [_backImageView setImage:[UIImage imageNamed:@"MyToreHeader"]];
        [_backImageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _backImageView;
}


@end
