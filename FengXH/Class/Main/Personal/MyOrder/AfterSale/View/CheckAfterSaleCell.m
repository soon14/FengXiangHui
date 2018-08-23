//
//  CheckAfterSaleCell.m
//  FengXH
//
//  Created by sun on 2018/8/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "CheckAfterSaleCell.h"
#import "CheckAfterSaleResultModel.h"

@interface CheckAfterSaleCell ()

/** 状态 */
@property(nonatomic , strong)UILabel *statusLabel;
/** 流程 */
@property(nonatomic , strong)UILabel *flowLabel;
/** 处理方式 */
@property(nonatomic , strong)UILabel *methodLabel;
/** 退款原因 */
@property(nonatomic , strong)UILabel *reasonLabel;
/** 退款说明 */
@property(nonatomic , strong)UILabel *explainLabel;
/** 退款金额 */
@property(nonatomic , strong)UILabel *foundLabel;
/** 退款时间 */
@property(nonatomic , strong)UILabel *timeLabel;

@end

@implementation CheckAfterSaleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.statusLabel];
        self.statusLabel.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .rightSpaceToView(self.contentView, 12)
        .topSpaceToView(self.contentView, 20)
        .autoHeightRatio(0);
        
        [self.contentView addSubview:self.flowLabel];
        self.flowLabel.sd_layout
        .topSpaceToView(self.statusLabel, 30)
        .leftEqualToView(self.statusLabel)
        .rightEqualToView(self.statusLabel)
        .autoHeightRatio(0);
        
        UIView *backView = [[UIView alloc] init];
        [backView setBackgroundColor:KTableBackgroundColor];
        [self.contentView addSubview:backView];
        backView.sd_layout
        .leftEqualToView(self.contentView)
        .topSpaceToView(self.flowLabel, 15)
        .rightEqualToView(self.contentView)
        .heightIs(40);
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KUIColorFromHex(0x333333)];
        [label setFont:KFont(15)];
        [label setText:@"协商详情"];
        [backView addSubview:label];
        label.sd_layout
        .topEqualToView(backView)
        .leftSpaceToView(backView, 12)
        .rightSpaceToView(backView, 12)
        .bottomEqualToView(backView);
        
        [self.contentView addSubview:self.methodLabel];
        self.methodLabel.sd_layout
        .leftEqualToView(self.statusLabel)
        .rightEqualToView(self.statusLabel)
        .topSpaceToView(backView, 10)
        .heightIs(24);
        
        [self.contentView addSubview:self.reasonLabel];
        self.reasonLabel.sd_layout
        .leftEqualToView(self.statusLabel)
        .rightEqualToView(self.statusLabel)
        .topSpaceToView(self.methodLabel, 5)
        .heightIs(24);
        
        [self.contentView addSubview:self.explainLabel];
        self.explainLabel.sd_layout
        .leftEqualToView(self.statusLabel)
        .rightEqualToView(self.statusLabel)
        .topSpaceToView(self.reasonLabel, 5)
        .heightIs(24);
        
        [self.contentView addSubview:self.foundLabel];
        self.foundLabel.sd_layout
        .leftEqualToView(self.statusLabel)
        .rightEqualToView(self.statusLabel)
        .topSpaceToView(self.explainLabel, 5)
        .heightIs(24);
        
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.sd_layout
        .leftEqualToView(self.statusLabel)
        .rightEqualToView(self.statusLabel)
        .topSpaceToView(self.foundLabel, 5)
        .heightIs(24);
        
    }
    return self;
}

- (void)setCheckAfterSaleResultModel:(CheckAfterSaleResultModel *)checkAfterSaleResultModel {
    _checkAfterSaleResultModel = checkAfterSaleResultModel;
    if ([_checkAfterSaleResultModel.status integerValue] >= 3) {
        [self.statusLabel setText:@"商家已经通过"];
    } else {
        [self.statusLabel setText:@"等待商家处理"];
    }
    //流程
    if ([_checkAfterSaleResultModel.rtype integerValue] == 0) {
        [self.flowLabel setText:@"退款申请流程：\n1、发起退款申请\n2、商家确认后退款到您的账户如果商家未处理：请及时与商家联系"];
    } else if ([_checkAfterSaleResultModel.rtype integerValue] == 1) {
        [self.flowLabel setText:@"退款退货申请流程：\n1、发起退款退货申请\n2、退货需将退货商品邮寄至商家指定地址，并在系统内输入快递单号\n3、商家收货后确认无误\n4、退款到您的账户"];
    } else if ([_checkAfterSaleResultModel.rtype integerValue] == 2) {
        [self.flowLabel setText:@"换货申请流程：\n1、发起换货申请，并把快递单号录入系统\n2、将需要换货的商品邮寄至商家指定地址，并在系统内输入快递单号\n3、商家确认后货后重新发出商品\n4、签收确认"];
    }
    if ([_checkAfterSaleResultModel.rtype integerValue] == 0) {
        [self.methodLabel setText:@"处理方式\t退款"];
    } else if ([_checkAfterSaleResultModel.rtype integerValue] == 1) {
        [self.methodLabel setText:@"处理方式\t退货"];
    } else if ([_checkAfterSaleResultModel.rtype integerValue] == 2) {
        [self.methodLabel setText:@"处理方式\t换货"];
    }
    [self.reasonLabel setText:[NSString stringWithFormat:@"退款原因\t%@",_checkAfterSaleResultModel.reason]];
    [self.explainLabel setText:[NSString stringWithFormat:@"退款说明\t%@",_checkAfterSaleResultModel.content]];
    [self.foundLabel setText:[NSString stringWithFormat:@"退款金额\t¥ %.2f",[_checkAfterSaleResultModel.applyprice floatValue]]];
    [self.timeLabel setText:[NSString stringWithFormat:@"申请时间\t%@",_checkAfterSaleResultModel.createtime]];
    
    [self setupAutoHeightWithBottomView:self.timeLabel bottomMargin:10];
}


#pragma mark - lazy
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setTextColor:KUIColorFromHex(0x666666)];
        [_timeLabel setFont:KFont(14)];
    }
    return _timeLabel;
}

- (UILabel *)foundLabel {
    if (!_foundLabel) {
        _foundLabel = [[UILabel alloc] init];
        [_foundLabel setTextColor:KUIColorFromHex(0x666666)];
        [_foundLabel setFont:KFont(14)];
    }
    return _foundLabel;
}

- (UILabel *)explainLabel {
    if (!_explainLabel) {
        _explainLabel = [[UILabel alloc] init];
        [_explainLabel setTextColor:KUIColorFromHex(0x666666)];
        [_explainLabel setFont:KFont(14)];
    }
    return _explainLabel;
}

- (UILabel *)reasonLabel {
    if (!_reasonLabel) {
        _reasonLabel = [[UILabel alloc] init];
        [_reasonLabel setTextColor:KUIColorFromHex(0x666666)];
        [_reasonLabel setFont:KFont(14)];
    }
    return _reasonLabel;
}

- (UILabel *)methodLabel {
    if (!_methodLabel) {
        _methodLabel = [[UILabel alloc] init];
        [_methodLabel setTextColor:KUIColorFromHex(0x666666)];
        [_methodLabel setFont:KFont(14)];
    }
    return _methodLabel;
}

- (UILabel *)flowLabel {
    if (!_flowLabel) {
        _flowLabel = [[UILabel alloc] init];
        [_flowLabel setTextColor:KUIColorFromHex(0x666666)];
        [_flowLabel setFont:KFont(14)];
    }
    return _flowLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        [_statusLabel setTextColor:KUIColorFromHex(0x333333)];
        [_statusLabel setFont:KFont(20)];
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
