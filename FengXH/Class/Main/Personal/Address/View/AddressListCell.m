//
//  AddressListCell.m
//  FengXH
//
//  Created by sun on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AddressListCell.h"
#import "AddressResultModel.h"

@interface AddressListCell ()

/** 收货人电话 */
@property(nonatomic , strong)UILabel *namePhoneLabel;
/** 地址 */
@property(nonatomic , strong)UILabel *addressLabel;
/** 编辑按钮 */
@property(nonatomic , strong)UIButton *editButton;
/** 删除按钮 */
@property(nonatomic , strong)UIButton *deleteButton;
/** 设为默认 */
@property(nonatomic , strong)UIButton *setDefaultButton;

@end

@implementation AddressListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.namePhoneLabel];
        [self.namePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(16);
            make.top.mas_offset(20);
            make.right.mas_offset(-16);
        }];
        
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_namePhoneLabel.mas_left);
            make.right.mas_equalTo(_namePhoneLabel.mas_right);
            make.top.mas_equalTo(_namePhoneLabel.mas_bottom).offset(10);
        }];
        
        [self.contentView addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(50);
        }];
        
        [self.contentView addSubview:self.editButton];
        [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.right.mas_equalTo(_deleteButton.mas_left).offset(-10);
            make.width.mas_equalTo(_deleteButton.mas_width);
            make.height.mas_equalTo(_deleteButton.mas_height);
        }];
        
        [self.contentView addSubview:self.setDefaultButton];
        [self.setDefaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.left.mas_offset(10);
            make.width.mas_equalTo(85);
            make.height.mas_equalTo(_deleteButton.mas_height);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.bottom.mas_offset(-35);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)setAddressModel:(AddressResultListModel *)addressModel {
    _addressModel = addressModel;
    [self.namePhoneLabel setText:[NSString stringWithFormat:@"%@\t%@",_addressModel.realname,_addressModel.mobile]];
    [self.addressLabel setText:[NSString stringWithFormat:@"%@ %@ %@ %@ %@",_addressModel.province,_addressModel.city,_addressModel.area,_addressModel.town,_addressModel.address]];
    [self.setDefaultButton setSelected:_addressModel.isdefault];
}

#pragma mark - action
- (void)buttonAction:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock(sender.tag, self.addressModel);
    }
}


#pragma mark - lazy
- (UIButton *)setDefaultButton {
    if (!_setDefaultButton) {
        _setDefaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setDefaultButton setImage:[UIImage imageNamed:@"shopCar_btn_check_nor"] forState:UIControlStateNormal];
        [_setDefaultButton setImage:[UIImage imageNamed:@"shopCar_btn_check_sel"] forState:UIControlStateSelected];
        [_setDefaultButton setTitle:@"设为默认" forState:UIControlStateNormal];
        [_setDefaultButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_setDefaultButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
        [_setDefaultButton.titleLabel setFont:KFont(13)];
        [_setDefaultButton setTag:0];
        [_setDefaultButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setDefaultButton;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitleColor:KUIColorFromHex(0x999999) forState:UIControlStateNormal];
        [_editButton.titleLabel setFont:KFont(13)];
        [_editButton setTag:1];
        [_editButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:KUIColorFromHex(0x999999) forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont:KFont(13)];
        [_deleteButton setTag:2];
        [_deleteButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        [_addressLabel setTextColor:KUIColorFromHex(0x666666)];
        [_addressLabel setFont:KFont(14)];
        [_addressLabel setNumberOfLines:2];
    }
    return _addressLabel;
}

- (UILabel *)namePhoneLabel {
    if (!_namePhoneLabel) {
        _namePhoneLabel = [[UILabel alloc] init];
        [_namePhoneLabel setTextColor:KUIColorFromHex(0x333333)];
        [_namePhoneLabel setFont:KFont(15)];
    }
    return _namePhoneLabel;
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
