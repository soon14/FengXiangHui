//
//  PaySuccessAddressCell.m
//  FengXH
//
//  Created by sun on 2018/8/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PaySuccessAddressCell.h"
#import "PaySuccessResultModel.h"

@interface PaySuccessAddressCell ()

/** 收货人姓名 */
@property(nonatomic , strong)UILabel *nameLabel;
/** 联系人电话 */
@property(nonatomic , strong)UILabel *phoneLabel;
/** 地址 */
@property(nonatomic , strong)UILabel *addressLabel;

@end

@implementation PaySuccessAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *adImageView = [[UIImageView alloc] init];
        [adImageView setImage:[UIImage imageNamed:@"personal_myAddress"]];
        [adImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:adImageView];
        [adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(16);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.width.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(adImageView.mas_right).offset(16);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_offset(-5);
        }];
        
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_phoneLabel.mas_left);
            make.right.mas_equalTo(_phoneLabel.mas_right);
            make.bottom.mas_equalTo(_phoneLabel.mas_top).offset(-5);
        }];
        
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_phoneLabel.mas_left);
            make.right.mas_equalTo(_phoneLabel.mas_right);
            make.top.mas_equalTo(_phoneLabel.mas_bottom).offset(5);
        }];
        
        
    }
    return self;
}

- (void)setSuccessAddressModel:(PaySuccessResultDataAddressModel *)successAddressModel {
    _successAddressModel = successAddressModel;
    [self.nameLabel setText:[NSString stringWithFormat:@"联系人：%@",_successAddressModel.name?_successAddressModel.name:@""]];
    [self.phoneLabel setText:[NSString stringWithFormat:@"联系电话：%@",_successAddressModel.mobile?_successAddressModel.mobile:@""]];
    [self.addressLabel setText:[NSString stringWithFormat:@"%@",_successAddressModel.address?_successAddressModel.address:@""]];
}



#pragma mark - lazy
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        [_addressLabel setTextColor:KUIColorFromHex(0x333333)];
        [_addressLabel setFont:KFont(14)];
        [_addressLabel setAdjustsFontSizeToFitWidth:YES];
        [_addressLabel setText:@"福建省厦门市个股与与口语交际霍建华进货价孤鸿寡鹄"];
    }
    return _addressLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        [_phoneLabel setTextColor:KUIColorFromHex(0x333333)];
        [_phoneLabel setFont:KFont(15)];
        [_phoneLabel setText:@"联系电话："];
    }
    return _phoneLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_nameLabel setFont:KFont(15)];
        [_nameLabel setText:@"联系人"];
    }
    return _nameLabel;
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
