//
//  ConfirmOrderDetailPriceCell.m
//  FengXH
//
//  Created by sun on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderDetailPriceCell.h"
#import "ConfirmOrderCreatResultModel.h"

@interface ConfirmOrderDetailPriceCell ()

/** 购物送话费 */
@property(nonatomic , strong)UILabel *tariffeLabel;
/** 商品小计 */
@property(nonatomic , strong)UILabel *goodsPriceLabel;
/** 运费 */
@property(nonatomic , strong)UILabel *freightLabel;
/** 会员优惠 */
@property(nonatomic , strong)UILabel *membersLabel;

@end

@implementation ConfirmOrderDetailPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label_1 = [[UILabel alloc] init];
        [label_1 setTextColor:KUIColorFromHex(0x999999)];
        [label_1 setFont:KFont(14)];
        [label_1 setText:@"购物送话费"];
        [self.contentView addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.top.mas_offset(0);
            make.height.mas_equalTo(40);
        }];
        
        [self.contentView addSubview:self.tariffeLabel];
        [self.tariffeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.top.mas_offset(0);
            make.height.mas_equalTo(40);
        }];
        
        UILabel *label_2 = [[UILabel alloc] init];
        [label_2 setTextColor:KUIColorFromHex(0x999999)];
        [label_2 setFont:KFont(14)];
        [label_2 setText:@"商品小计"];
        [self.contentView addSubview:label_2];
        [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.top.mas_equalTo(label_1.mas_bottom).offset(0);
            make.height.mas_equalTo(40);
        }];
        
        [self.contentView addSubview:self.goodsPriceLabel];
        [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.top.mas_equalTo(label_1.mas_bottom).offset(0);
            make.height.mas_equalTo(40);
        }];
        
        
        UILabel *label_3 = [[UILabel alloc] init];
        [label_3 setTextColor:KUIColorFromHex(0x999999)];
        [label_3 setFont:KFont(14)];
        [label_3 setText:@"运费"];
        [self.contentView addSubview:label_3];
        [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.top.mas_equalTo(label_2.mas_bottom).offset(0);
            make.height.mas_equalTo(40);
        }];
        
        [self.contentView addSubview:self.freightLabel];
        [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.top.mas_equalTo(label_2.mas_bottom).offset(0);
            make.height.mas_equalTo(40);
        }];
        
        
        UILabel *label_4 = [[UILabel alloc] init];
        [label_4 setTextColor:KUIColorFromHex(0x999999)];
        [label_4 setFont:KFont(14)];
        [label_4 setText:@"会员优惠"];
        [self.contentView addSubview:label_4];
        [label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.top.mas_equalTo(label_3.mas_bottom).offset(0);
            make.height.mas_equalTo(40);
        }];
        
        [self.contentView addSubview:self.membersLabel];
        [self.membersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.top.mas_equalTo(label_3.mas_bottom).offset(0);
            make.height.mas_equalTo(40);
        }];
        
        
        for (NSInteger i=1; i<4; i++) {
            UIView *line = [[UIView alloc] init];
            [line setBackgroundColor:KLineColor];
            [self.contentView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_offset(0);
                make.height.mas_equalTo(0.5);
                make.top.mas_offset(40*i);
            }];
        }
        
    }
    return self;
}

- (void)setResultModel:(ConfirmOrderCreatResultModel *)resultModel {
    _resultModel = resultModel;
    
    //计算价 购物送话费
    float totalPrice = 0;
    totalPrice = ([_resultModel.subtotalprice floatValue] + [_resultModel.dispatch_price floatValue]) - ([_resultModel.discountprice floatValue]);
    
    [self.tariffeLabel setText:[NSString stringWithFormat:@"¥ %.2f",totalPrice]];
    [self.goodsPriceLabel setText:[NSString stringWithFormat:@"¥ %.2f",[_resultModel.subtotalprice floatValue]]];
    [self.freightLabel setText:[NSString stringWithFormat:@"¥ %.2f",[_resultModel.dispatch_price floatValue]]];
    [self.membersLabel setText:[NSString stringWithFormat:@"¥ %.2f",[_resultModel.discountprice floatValue]]];
}

#pragma mark - lazy
- (UILabel *)membersLabel {
    if (!_membersLabel) {
        _membersLabel = [[UILabel alloc] init];
        [_membersLabel setTextColor:KUIColorFromHex(0x333333)];
        [_membersLabel setFont:KFont(14)];
        [_membersLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _membersLabel;
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

- (UILabel *)goodsPriceLabel {
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] init];
        [_goodsPriceLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsPriceLabel setFont:KFont(14)];
        [_goodsPriceLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _goodsPriceLabel;
}

- (UILabel *)tariffeLabel {
    if (!_tariffeLabel) {
        _tariffeLabel = [[UILabel alloc] init];
        [_tariffeLabel setTextColor:KUIColorFromHex(0x333333)];
        [_tariffeLabel setFont:KFont(14)];
        [_tariffeLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _tariffeLabel;
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
