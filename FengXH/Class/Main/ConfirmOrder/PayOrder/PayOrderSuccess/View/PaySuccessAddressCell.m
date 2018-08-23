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

/** 收货人电话 */
@property(nonatomic , strong)UILabel *namePhoneLabel;
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
        
        [self.contentView addSubview:self.namePhoneLabel];
        [self.namePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(adImageView.mas_right).offset(16);
            make.right.mas_offset(-5);
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

- (void)setSuccessAddressModel:(PaySuccessResultDataAddressModel *)successAddressModel {
    _successAddressModel = successAddressModel;
    [self.namePhoneLabel setText:[NSString stringWithFormat:@"联系人：%@",_successAddressModel.name?_successAddressModel.name:@""]];
    [self.addressLabel setText:[NSString stringWithFormat:@"联系电话：%@",_successAddressModel.mobile?_successAddressModel.mobile:@""]];
}



#pragma mark - lazy
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        [_addressLabel setTextColor:KUIColorFromHex(0x333333)];
        [_addressLabel setFont:KFont(15)];
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
