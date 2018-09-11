//
//  PaySuccessPriceCell.m
//  FengXH
//
//  Created by sun on 2018/8/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PaySuccessPriceCell.h"
#import "PaySuccessResultModel.h"

@interface PaySuccessPriceCell ()

/** 价格 */
@property(nonatomic , strong)UILabel *priceLabel;

@end

@implementation PaySuccessPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KUIColorFromHex(0x666666)];
        [label setFont:KFont(15)];
        [label setText:@"实付金额"];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(16);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}

- (void)setSuccessDataModel:(PaySuccessResultDataModel *)successDataModel {
    _successDataModel = successDataModel;
    if (_successDataModel.price) {
        [self.priceLabel setText:[NSString stringWithFormat:@"¥ %.2f",[_successDataModel.price floatValue]]];
    }
    
}


- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor:KRedColor];
        [_priceLabel setFont:KFont(15)];
        [_priceLabel setTextAlignment:NSTextAlignmentRight];
        [_priceLabel setText:@"¥ 700"];
    }
    return _priceLabel;
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
