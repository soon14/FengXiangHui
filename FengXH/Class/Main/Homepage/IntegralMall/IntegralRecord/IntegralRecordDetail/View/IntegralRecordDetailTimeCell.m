//
//  IntegralRecordDetailTimeCell.m
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordDetailTimeCell.h"
#import "IntegralRecordDetailResultModel.h"

@interface IntegralRecordDetailTimeCell ()

/** 订单编号 */
@property(nonatomic , strong)UILabel *ordernoLabel;
/** 创建时间 */
@property(nonatomic , strong)UILabel *creatTimeLabel;
/** 支付时间 */
@property(nonatomic , strong)UILabel *payTimeLabel;

@end

@implementation IntegralRecordDetailTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.ordernoLabel];
        [self.ordernoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_offset(10);
            make.height.mas_equalTo(25);
        }];
        
        [self.contentView addSubview:self.creatTimeLabel];
        [self.creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_ordernoLabel.mas_left);
            make.top.mas_equalTo(_ordernoLabel.mas_bottom);
            make.height.mas_equalTo(25);
        }];
        
        [self.contentView addSubview:self.payTimeLabel];
        [self.payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_ordernoLabel.mas_left);
            make.top.mas_equalTo(_creatTimeLabel.mas_bottom);
            make.height.mas_equalTo(25);
        }];
        
    }
    return self;
}

- (void)setDetailResultModel:(IntegralRecordDetailResultModel *)detailResultModel {
    _detailResultModel = detailResultModel;
    
    NSMutableAttributedString *ordernoString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"订单编号：%@",_detailResultModel.logno]];
    [ordernoString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x666666)} range:NSMakeRange(0, 5)];
    [self.ordernoLabel setAttributedText:ordernoString];
    
    NSMutableAttributedString *creatTimeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"创建时间：%@",_detailResultModel.createtime]];
    [creatTimeString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x666666)} range:NSMakeRange(0, 5)];
    [self.creatTimeLabel setAttributedText:creatTimeString];
    
    NSMutableAttributedString *payTimeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"支付时间：%@",_detailResultModel.paytime]];
    [payTimeString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x666666)} range:NSMakeRange(0, 5)];
    [self.payTimeLabel setAttributedText:payTimeString];
    
}

#pragma mark - lazy
- (UILabel *)payTimeLabel {
    if (!_payTimeLabel) {
        _payTimeLabel = [[UILabel alloc] init];
        [_payTimeLabel setTextColor:KUIColorFromHex(0x333333)];
        [_payTimeLabel setFont:KFont(14)];
    }
    return _payTimeLabel;
}

- (UILabel *)creatTimeLabel {
    if (!_creatTimeLabel) {
        _creatTimeLabel = [[UILabel alloc] init];
        [_creatTimeLabel setTextColor:KUIColorFromHex(0x333333)];
        [_creatTimeLabel setFont:KFont(14)];
    }
    return _creatTimeLabel;
}

- (UILabel *)ordernoLabel {
    if (!_ordernoLabel) {
        _ordernoLabel = [[UILabel alloc] init];
        [_ordernoLabel setTextColor:KUIColorFromHex(0x333333)];
        [_ordernoLabel setFont:KFont(14)];
    }
    return _ordernoLabel;
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
