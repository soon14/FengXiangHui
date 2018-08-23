//
//  IntegralCreatOrderPriceCell.m
//  FengXH
//
//  Created by sun on 2018/8/22.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "IntegralCreatOrderPriceCell.h"
#import "IntegralCreatOrderResultModel.h"

@interface IntegralCreatOrderPriceCell ()

/** 商品小计 */
@property(nonatomic , strong)UILabel *goodsPriceLabel;
/** 运费 */
@property(nonatomic , strong)UILabel *freightLabel;

@end

@implementation IntegralCreatOrderPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *label_1 = [[UILabel alloc] init];
        [label_1 setTextColor:KUIColorFromHex(0x333333)];
        [label_1 setFont:KFont(14)];
        [label_1 setText:@"商品小计"];
        [self.contentView addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.mas_offset(12);
            make.bottom.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.goodsPriceLabel];
        [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.centerY.mas_equalTo(label_1.mas_centerY);
        }];
        
        UILabel *label_2 = [[UILabel alloc] init];
        [label_2 setTextColor:KUIColorFromHex(0x333333)];
        [label_2 setFont:KFont(14)];
        [label_2 setText:@"运费"];
        [self.contentView addSubview:label_2];
        [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_offset(12);
            make.bottom.mas_offset(0);
        }];
        
        [self.contentView addSubview:self.freightLabel];
        [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.centerY.mas_equalTo(label_2.mas_centerY);
        }];
        
    }
    return self;
}

- (void)setResultModel:(IntegralCreatOrderResultModel *)resultModel {
    _resultModel = resultModel;
    [self.goodsPriceLabel setText:_resultModel.subtotal];
    [self.freightLabel setText:_resultModel.dispatch];
}


#pragma mark - lazy
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
