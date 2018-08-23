//
//  GroupPriceTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupPriceTableViewCell.h"

@interface GroupPriceTableViewCell()
@property (nonatomic ,strong) UILabel *title;
@property (nonatomic ,strong) UILabel *price;
@end

@implementation GroupPriceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
        [self addSubview:self.price];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.bottom.right.mas_offset(-10);
        }];
    }
    return self;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = [UIColor blackColor];
        [_title setTextAlignment:NSTextAlignmentLeft];
        _title.font = KFont(15);
        _title.textColor = KUIColorFromHex(0x666666);
        
    }
    return _title;
}
- (UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc]init];
        _price.textColor = [UIColor blackColor];
        [_price setTextAlignment:NSTextAlignmentRight];
        _price.font = KFont(15);
        _price.textColor = [UIColor blackColor];
    }
    return _price;
}
- (void)setTitle:(NSString *)title setPrice:(NSString *)price{
    self.title.text = title;
    self.price.text = [NSString stringWithFormat:@"¥%@",price];
}
@end
