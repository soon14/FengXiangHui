//
//  OrderDetailStatusCell.m
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderDetailStatusCell.h"
#import "OrderDetailResultModel.h"

@interface OrderDetailStatusCell ()

/** 状态 */
@property(nonatomic , strong)UILabel *statusLabel;
/** 价格 */
@property(nonatomic , strong)UILabel *priceLabel;

@end

@implementation OrderDetailStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor orangeColor];
        
        [self.contentView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(12);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_statusLabel.mas_bottom).offset(5);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
    }
    return self;
}

- (void)setStatusModel:(OrderDetailResultModel *)statusModel {
    _statusModel = statusModel;
    [self.statusLabel setText:[NSString stringWithFormat:@"%@%@",_statusModel.status,_statusModel.refundstate?_statusModel.refundstate:@""]];
    [self.priceLabel setText:[NSString stringWithFormat:@"订单金额：%@",_statusModel.goodsprice]];
}


#pragma mark - lazy
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor:[UIColor whiteColor]];
        [_priceLabel setFont:KFont(14)];
        [_priceLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _priceLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        [_statusLabel setTextColor:[UIColor whiteColor]];
        [_statusLabel setFont:KFont(17)];
        [_statusLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _statusLabel;
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
