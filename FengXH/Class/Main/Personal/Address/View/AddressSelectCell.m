//
//  AddressSelectCell.m
//  FengXH
//
//  Created by sun on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AddressSelectCell.h"
#import "AddressResultModel.h"

@interface AddressSelectCell ()

/** 选中 */
@property(nonatomic , strong)UIImageView *selectedImageView;
/** 收货人电话 */
@property(nonatomic , strong)UILabel *namePhoneLabel;
/** 地址 */
@property(nonatomic , strong)UILabel *addressLabel;
/** 编辑按钮 */
@property(nonatomic , strong)UIButton *editButton;

@end

@implementation AddressSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [imageV setImage:[UIImage imageNamed:@"personalAddressEdit"]];
        [imageV setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-16);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.editButton];
        [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.bottom.mas_offset(-10);
            make.right.mas_offset(0);
            make.width.mas_equalTo(36);
        }];
        
        [self.contentView addSubview:self.selectedImageView];
        [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(16);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.namePhoneLabel];
        [self.namePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_selectedImageView.mas_right).offset(16);
            make.right.mas_offset(-40);
            make.bottom.mas_equalTo(self.contentView.mas_centerY).offset(-5);
        }];
        
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_namePhoneLabel.mas_left);
            make.right.mas_equalTo(_namePhoneLabel.mas_right);
            make.top.mas_equalTo(self.contentView.mas_centerY).offset(0);
        }];
        
    }
    return self;
}

- (void)setAddressModel:(AddressResultListModel *)addressModel {
    _addressModel = addressModel;
    [self.namePhoneLabel setText:[NSString stringWithFormat:@"%@\t%@",_addressModel.realname,_addressModel.mobile]];
    if (_addressModel.isdefault == 1) {
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@  %@ %@ %@ %@ %@",@"默认",_addressModel.province?_addressModel.province:@"",_addressModel.city?_addressModel.city:@"",_addressModel.area?_addressModel.area:@"",_addressModel.town?_addressModel.town:@"",_addressModel.address?_addressModel.address:@""]];
        [aString addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:KFont(12),NSBackgroundColorAttributeName:KRedColor} range:NSMakeRange(0, 4)];
        [self.addressLabel setAttributedText:aString];
    } else {
        [self.addressLabel setText:[NSString stringWithFormat:@"%@ %@ %@ %@ %@",_addressModel.province?_addressModel.province:@"",_addressModel.city?_addressModel.city:@"",_addressModel.area?_addressModel.area:@"",_addressModel.town?_addressModel.town:@"",_addressModel.address?_addressModel.address:@""]];
    }
    if (_addressModel.selected) {
        [self.selectedImageView setImage:[UIImage imageNamed:@"personalAddressSelected"]];
    } else {
        [self.selectedImageView setImage:nil];
    }
}

#pragma mark - buttonAction
- (void)editButtonAction:(UIButton *)sender {
    if (self.editBlock) {
        self.editBlock(self.addressModel);
    }
}


#pragma mark - lazy
- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
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


- (UIImageView *)selectedImageView {
    if (!_selectedImageView) {
        _selectedImageView = [[UIImageView alloc] init];
        [_selectedImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _selectedImageView;
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
