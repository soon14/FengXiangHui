//
//  OrderDetailPriceCell.m
//  FengXH
//
//  Created by sun on 2018/8/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderDetailPriceCell.h"
#import "OrderDetailResultModel.h"

@interface OrderDetailPriceCell ()

/** total */
@property(nonatomic , strong)UILabel *totalPriceLabel;
/** 运费 */
@property(nonatomic , strong)UILabel *freightLabel;
/** F币 */
@property(nonatomic , strong)UILabel *FMoneyLabel;
/** 实付费 */
@property(nonatomic , strong)UILabel *payMoneyLabel;

@end

@implementation OrderDetailPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView *backView = [[UIView alloc] init];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_offset(6);
            make.bottom.mas_offset(-6);
        }];
        
        CGFloat LabelHeight = 30;
        
        NSArray *titleArr = @[@"商品小计",@"运费",@"F币抵扣",@"实付费(含运费)"];
        for (NSInteger i=0; i<4; i++) {
            UILabel *label = [[UILabel alloc] init];
            [label setTextColor:KUIColorFromHex(0x666666)];
            [label setFont:KFont(14)];
            [label setText:titleArr[i]];
            [backView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(12);
                make.top.mas_offset(LabelHeight*i);
                make.height.mas_equalTo(LabelHeight);
            }];
        }
        
        [backView addSubview:self.totalPriceLabel];
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(-12);
            make.height.mas_equalTo(LabelHeight);
        }];
        
        [backView addSubview:self.freightLabel];
        [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(LabelHeight);
            make.right.mas_offset(-12);
            make.height.mas_equalTo(LabelHeight);
        }];
        
        [backView addSubview:self.FMoneyLabel];
        [self.FMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_freightLabel.mas_bottom);
            make.right.mas_offset(-12);
            make.height.mas_equalTo(LabelHeight);
        }];
        
        [backView addSubview:self.payMoneyLabel];
        [self.payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.right.mas_offset(-12);
            make.height.mas_equalTo(LabelHeight);
        }];
        
    }
    return self;
}

- (void)setDetailResultModel:(OrderDetailResultModel *)detailResultModel {
    _detailResultModel = detailResultModel;
    [self.totalPriceLabel setText:[NSString stringWithFormat:@"¥ %.2f",[_detailResultModel.goodsprice floatValue]]];
    [self.freightLabel setText:[NSString stringWithFormat:@"¥ %.2f",[_detailResultModel.dispatchprice floatValue]]];
    [self.FMoneyLabel setText:[NSString stringWithFormat:@"-¥ %.2f",[_detailResultModel.deductcredit2 floatValue]]];
    [self.payMoneyLabel setText:[NSString stringWithFormat:@"¥ %.2f",[_detailResultModel.price floatValue]]];
}

#pragma mark - lazy
- (UILabel *)payMoneyLabel {
    if (!_payMoneyLabel) {
        _payMoneyLabel = [[UILabel alloc] init];
        [_payMoneyLabel setTextColor:KRedColor];
        [_payMoneyLabel setFont:KFont(14)];
        [_payMoneyLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _payMoneyLabel;
}

- (UILabel *)FMoneyLabel {
    if (!_FMoneyLabel) {
        _FMoneyLabel = [[UILabel alloc] init];
        [_FMoneyLabel setTextColor:KUIColorFromHex(0x333333)];
        [_FMoneyLabel setFont:KFont(14)];
        [_FMoneyLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _FMoneyLabel;
}

- (UILabel *)freightLabel {
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc] init];
        [_freightLabel setTextColor:KUIColorFromHex(0x333333)];
        [_freightLabel setFont:KFont(14)];
        [_freightLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _freightLabel;
}

- (UILabel *)totalPriceLabel {
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc] init];
        [_totalPriceLabel setTextColor:KUIColorFromHex(0x333333)];
        [_totalPriceLabel setFont:KFont(14)];
        [_totalPriceLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _totalPriceLabel;
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
