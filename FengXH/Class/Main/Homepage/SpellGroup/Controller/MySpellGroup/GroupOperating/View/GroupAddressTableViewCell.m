//
//  GroupAddressTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupAddressTableViewCell.h"
#import "AddressResultModel.h"
@interface GroupAddressTableViewCell()
@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *address;
@property (nonatomic ,strong)UIView *line;
@property (nonatomic ,strong)UIImageView *img;//箭头
@end
@implementation GroupAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(10);
        }];
        [self addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.mas_offset(30);
            make.bottom.mas_equalTo(self.line.mas_top).offset(-30);
        }];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.left.mas_offset(20);
            make.height.mas_equalTo(20);
            
        }];
        [self addSubview:self.address];
        [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.line.mas_top).offset(-10);
            make.left.mas_offset(20);
            make.height.mas_equalTo(20);
            
        }];
    }
    return self;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = KTableBackgroundColor;
    }
    return _line;
}
- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]init];
        _img.image = [UIImage imageNamed:@"home_icon_arrow"];
    }
    return _img;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = [UIColor blackColor];
        _title.font = KFont(13);
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}
- (UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc]init];
        _address.textColor = KUIColorFromHex(0x666666);
        _address.font = KFont(13);
        _address.textAlignment = NSTextAlignmentLeft;
    }
    return _address;
}
- (void)setAddressResultListModel:(AddressResultListModel *)addressResultListModel{
    _addressResultListModel = addressResultListModel;
    _title.text = [NSString stringWithFormat:@"收货人： %@   %@",_addressResultListModel.realname,_addressResultListModel.mobile];
    _address.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",_addressResultListModel.province,_addressResultListModel.city,_addressResultListModel.area,_addressResultListModel.town,_addressResultListModel.address];
}
@end
