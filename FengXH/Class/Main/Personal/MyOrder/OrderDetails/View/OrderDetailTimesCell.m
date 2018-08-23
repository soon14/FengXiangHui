//
//  OrderDetailTimesCell.m
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderDetailTimesCell.h"
#import "OrderDetailResultModel.h"

@interface OrderDetailTimesCell ()

/** 订单编号 */
@property(nonatomic , strong)UILabel *orderNumberLabel;
/** 创建时间 */
@property(nonatomic , strong)UILabel *creatTimeLabel;
/** 支付时间 */
@property(nonatomic , strong)UILabel *payTimeLabel;
/** 发货时间 */
@property(nonatomic , strong)UILabel *sendTimeLabel;
/** 完成时间 */
@property(nonatomic , strong)UILabel *completeTimeLabel;

@end

@implementation OrderDetailTimesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.orderNumberLabel];
        self.orderNumberLabel.sd_layout
        .topSpaceToView(self.contentView, 12)
        .leftSpaceToView(self.contentView, 12)
        .widthIs(KMAINSIZE.width-24)
        .autoHeightRatio(0);
        
        [self.contentView addSubview:self.creatTimeLabel];
        self.creatTimeLabel.sd_layout
        .topSpaceToView(self.orderNumberLabel, 6)
        .leftEqualToView(self.orderNumberLabel)
        .widthIs(KMAINSIZE.width-24)
        .autoHeightRatio(0);
        
        [self.contentView addSubview:self.payTimeLabel];
        self.payTimeLabel.sd_layout
        .topSpaceToView(self.creatTimeLabel, 6)
        .leftEqualToView(self.orderNumberLabel)
        .widthIs(KMAINSIZE.width-24)
        .autoHeightRatio(0);
        
        [self.contentView addSubview:self.sendTimeLabel];
        self.sendTimeLabel.sd_layout
        .topSpaceToView(self.payTimeLabel, 6)
        .leftEqualToView(self.orderNumberLabel)
        .widthIs(KMAINSIZE.width-24)
        .autoHeightRatio(0);
        
        [self.contentView addSubview:self.completeTimeLabel];
        self.completeTimeLabel.sd_layout
        .topSpaceToView(self.sendTimeLabel, 6)
        .leftEqualToView(self.orderNumberLabel)
        .widthIs(KMAINSIZE.width-24)
        .autoHeightRatio(0);
        
    }
    return self;
}

- (void)setTimesDetailResultModel:(OrderDetailResultModel *)timesDetailResultModel {
    _timesDetailResultModel = timesDetailResultModel;
    
    if (_timesDetailResultModel.ordersn) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"订单编号  %@",_timesDetailResultModel.ordersn]];
        [attributedString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x333333)} range:NSMakeRange(6, attributedString.length-6)];
        [self.orderNumberLabel setAttributedText:attributedString];
    }
    
    if (_timesDetailResultModel.createtime) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"创建时间  %@",_timesDetailResultModel.createtime]];
        [attributedString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x333333)} range:NSMakeRange(6, attributedString.length-6)];
        [self.creatTimeLabel setAttributedText:attributedString];
    }

    if (_timesDetailResultModel.paytime) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"支付时间  %@",_timesDetailResultModel.paytime]];
        [attributedString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x333333)} range:NSMakeRange(6, attributedString.length-6)];
        [self.payTimeLabel setAttributedText:attributedString];
    }
    
    if (_timesDetailResultModel.sendtime) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"发货时间  %@",_timesDetailResultModel.sendtime]];
        [attributedString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x333333)} range:NSMakeRange(6, attributedString.length-6)];
        [self.sendTimeLabel setAttributedText:attributedString];
    }
    
    if (_timesDetailResultModel.acctime) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"完成时间  %@",_timesDetailResultModel.acctime]];
        [attributedString addAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0x333333)} range:NSMakeRange(6, attributedString.length-6)];
        [self.completeTimeLabel setAttributedText:attributedString];
    }
    
    if (_timesDetailResultModel.acctime) {
        [self setupAutoHeightWithBottomView:self.completeTimeLabel bottomMargin:12];
    } else if (_timesDetailResultModel.sendtime) {
        [self setupAutoHeightWithBottomView:self.sendTimeLabel bottomMargin:12];
    } else if (_timesDetailResultModel.paytime) {
        [self setupAutoHeightWithBottomView:self.payTimeLabel bottomMargin:12];
    } else {
        [self setupAutoHeightWithBottomView:self.creatTimeLabel bottomMargin:12];
    }
    
}


#pragma mark - lazy
- (UILabel *)completeTimeLabel {
    if (!_completeTimeLabel) {
        _completeTimeLabel = [[UILabel alloc] init];
        [_completeTimeLabel setTextColor:KUIColorFromHex(0x666666)];
        [_completeTimeLabel setFont:KFont(14)];
    }
    return _completeTimeLabel;
}

- (UILabel *)sendTimeLabel {
    if (!_sendTimeLabel) {
        _sendTimeLabel = [[UILabel alloc] init];
        [_sendTimeLabel setTextColor:KUIColorFromHex(0x666666)];
        [_sendTimeLabel setFont:KFont(14)];
    }
        return _sendTimeLabel;
}

- (UILabel *)payTimeLabel {
    if (!_payTimeLabel) {
        _payTimeLabel = [[UILabel alloc] init];
        [_payTimeLabel setTextColor:KUIColorFromHex(0x666666)];
        [_payTimeLabel setFont:KFont(14)];
    }
    return _payTimeLabel;
}

- (UILabel *)creatTimeLabel {
    if (!_creatTimeLabel) {
        _creatTimeLabel = [[UILabel alloc] init];
        [_creatTimeLabel setTextColor:KUIColorFromHex(0x666666)];
        [_creatTimeLabel setFont:KFont(14)];
    }
    return _creatTimeLabel;
}

- (UILabel *)orderNumberLabel {
    if (!_orderNumberLabel) {
        _orderNumberLabel = [[UILabel alloc] init];
        [_orderNumberLabel setTextColor:KUIColorFromHex(0x666666)];
        [_orderNumberLabel setFont:KFont(14)];
    }
    return _orderNumberLabel;
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
