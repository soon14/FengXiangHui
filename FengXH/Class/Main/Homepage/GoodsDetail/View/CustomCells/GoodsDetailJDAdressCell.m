//
//  GoodsDetailJDAdressCell.m
//  FengXH
//
//  Created by sun on 2018/9/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailJDAdressCell.h"

@interface GoodsDetailJDAdressCell ()

/** 地址 */
@property(nonatomic , strong)UILabel *addressLabel;

@end

@implementation GoodsDetailJDAdressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        [label setFont:KFont(13)];
        [label setTextColor:KUIColorFromHex(0x999999)];
        [label setText:@"送至"];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(30);
        }];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [imageV setImage:[UIImage imageNamed:@"GoodsDetailAdress"]];
        [self.contentView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_right).offset(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(12);
        }];
        
        UIImageView *moreImageV = [[UIImageView alloc] init];
        [moreImageV setImage:[UIImage imageNamed:@"GoodsDetailMore"]];
        [self.contentView addSubview:moreImageV];
        [moreImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(15);
        }];

        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.mas_equalTo(imageV.mas_right).offset(10);
            make.right.mas_equalTo(moreImageV.mas_left).offset(-10);
        }];
        
    }
    return self;
}

- (void)setAddress:(NSString *)address {
    _address = address;
    [self.addressLabel setText:_address];
}

#pragma mark - lazy
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        [_addressLabel setTextColor:KUIColorFromHex(0x333333)];
        [_addressLabel setFont:KFont(13)];
        [_addressLabel setText:@"选择"];
    }
    return _addressLabel;
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
