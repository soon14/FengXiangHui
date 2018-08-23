//
//  ConfirmOrderCouponPriceCell.m
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderCouponPriceCell.h"
#import "ConfirmOrderCouponPriceResultModel.h"

@interface ConfirmOrderCouponPriceCell ()

/** 优惠券优惠 */
@property(nonatomic , strong)UILabel *couponLabel;

@end

@implementation ConfirmOrderCouponPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label_1 = [[UILabel alloc] init];
        [label_1 setTextColor:KUIColorFromHex(0x999999)];
        [label_1 setFont:KFont(14)];
        [label_1 setText:@"优惠券优惠"];
        [self.contentView addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.top.bottom.mas_offset(0);
        }];
        
        [self.contentView addSubview:self.couponLabel];
        [self.couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.top.bottom.mas_offset(0);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)setCouponPriceModel:(ConfirmOrderCouponPriceResultModel *)couponPriceModel {
    _couponPriceModel = couponPriceModel;
    [self.couponLabel setText:[NSString stringWithFormat:@"¥ %.2f",[_couponPriceModel.deductprice floatValue]]];
}


#pragma mark - lazy
- (UILabel *)couponLabel {
    if (!_couponLabel) {
        _couponLabel = [[UILabel alloc] init];
        [_couponLabel setTextColor:KUIColorFromHex(0x333333)];
        [_couponLabel setFont:KFont(14)];
        [_couponLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _couponLabel;
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
