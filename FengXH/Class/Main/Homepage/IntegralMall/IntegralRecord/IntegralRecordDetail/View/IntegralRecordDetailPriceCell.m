//
//  IntegralRecordDetailPriceCell.m
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordDetailPriceCell.h"
#import "IntegralRecordDetailResultModel.h"

@interface IntegralRecordDetailPriceCell ()

/** s商品小计 */
@property(nonatomic , strong)UILabel *totalPriceLabel;
/** f运费 */
@property(nonatomic , strong)UILabel *freightLabel;
/** 实付 */
@property(nonatomic , strong)UILabel *payPriceLabel;

@end

@implementation IntegralRecordDetailPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        NSArray *titleArr = @[@"商品小计",@"运费",@"实付费(含运费)"];
        for (NSInteger i=0; i<3; i++) {
            UILabel *label = [[UILabel alloc] init];
            [label setTextColor:KUIColorFromHex(0x666666)];
            [label setFont:KFont(14)];
            [label setText:titleArr[i]];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(10);
                make.top.mas_offset(30*i+5);
                make.height.mas_equalTo(30);
            }];
        }
        
        [self.contentView addSubview:self.totalPriceLabel];
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(30);
        }];
        
        [self.contentView addSubview:self.freightLabel];
        [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(35);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(30);
        }];
        
        [self.contentView addSubview:self.payPriceLabel];
        [self.payPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-5);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(30);
        }];
        
    }
    return self;
}

- (void)setDetailResultModel:(IntegralRecordDetailResultModel *)detailResultModel {
    _detailResultModel = detailResultModel;
    if ([_detailResultModel.goods.money floatValue] > 0) {
        [self.totalPriceLabel setText:[NSString stringWithFormat:@"%ld 积分 + ¥%.2lf",(long)[_detailResultModel.goods.credit integerValue],[_detailResultModel.goods.money floatValue]]];
    } else {
        [self.totalPriceLabel setText:[NSString stringWithFormat:@"%ld 积分",(long)[_detailResultModel.goods.credit integerValue]]];
    }
    
    if ([_detailResultModel.dispatch floatValue] > 0) {
        [self.freightLabel setText:[NSString stringWithFormat:@"运费：%.2lf",[_detailResultModel.dispatch floatValue]]];
    } else {
        [self.freightLabel setText:@"免运费"];
    }
    
    if (([_detailResultModel.goods.money floatValue] + [_detailResultModel.dispatch floatValue]) > 0) {
        [self.payPriceLabel setText:[NSString stringWithFormat:@"%ld 积分 + ¥%.2lf",(long)[_detailResultModel.goods.credit integerValue],([_detailResultModel.goods.money floatValue] + [_detailResultModel.dispatch floatValue])]];
    } else {
        [self.payPriceLabel setText:[NSString stringWithFormat:@"%ld 积分",(long)[_detailResultModel.goods.credit integerValue]]];
    }
}

#pragma mark - lazy
- (UILabel *)payPriceLabel {
    if (!_payPriceLabel) {
        _payPriceLabel = [[UILabel alloc] init];
        [_payPriceLabel setTextColor:KUIColorFromHex(0x333333)];
        [_payPriceLabel setFont:KFont(14)];
        [_payPriceLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _payPriceLabel;
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
