//
//  PayOrderOrderInfoCell.m
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PayOrderOrderInfoCell.h"
#import "PayOrderResultModel.h"

@interface PayOrderOrderInfoCell ()

/** 订单编号 */
@property(nonatomic , strong)UILabel *orderNumberLabel;
/** 订单金额 */
@property(nonatomic , strong)UILabel *orderPriceLabel;

@end

@implementation PayOrderOrderInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label_1 = [[UILabel alloc] init];
        [label_1 setTextColor:KUIColorFromHex(0x666666)];
        [label_1 setFont:KFont(14)];
        [label_1 setText:@"订单编号"];
        [self.contentView addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.top.mas_offset(0);
            make.height.mas_equalTo(45);
        }];
        
        [self.contentView addSubview:self.orderNumberLabel];
        [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.top.mas_offset(0);
            make.height.mas_equalTo(45);
        }];
        
        
        UILabel *label_2 = [[UILabel alloc] init];
        [label_2 setTextColor:KUIColorFromHex(0x666666)];
        [label_2 setFont:KFont(14)];
        [label_2 setText:@"订单金额"];
        [self.contentView addSubview:label_2];
        [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.bottom.mas_offset(0);
            make.height.mas_equalTo(45);
        }];
        
        [self.contentView addSubview:self.orderPriceLabel];
        [self.orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.bottom.mas_offset(0);
            make.height.mas_equalTo(45);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.right.mas_offset(0);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setOrderResultModel:(PayOrderResultModel *)orderResultModel {
    _orderResultModel = orderResultModel;
    [self.orderNumberLabel setText:_orderResultModel.ordersn];
    [self.orderPriceLabel setText:[NSString stringWithFormat:@"¥ %@",_orderResultModel.price]];
}

#pragma mark - lazy
- (UILabel *)orderNumberLabel {
    if (!_orderNumberLabel) {
        _orderNumberLabel = [[UILabel alloc] init];
        [_orderNumberLabel setTextColor:KUIColorFromHex(0x333333)];
        [_orderNumberLabel setFont:KFont(14)];
        [_orderNumberLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _orderNumberLabel;
}

- (UILabel *)orderPriceLabel {
    if (!_orderPriceLabel) {
        _orderPriceLabel = [[UILabel alloc] init];
        [_orderPriceLabel setTextColor:KRedColor];
        [_orderPriceLabel setFont:KFont(14)];
        [_orderPriceLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _orderPriceLabel;
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
