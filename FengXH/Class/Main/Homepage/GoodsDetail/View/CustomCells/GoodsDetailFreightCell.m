//
//  GoodsDetailFreightCell.m
//  FengXH
//
//  Created by sun on 2018/9/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailFreightCell.h"
#import "GoodsDetailResultModel.h"

@interface GoodsDetailFreightCell ()

/** 运费 */
@property(nonatomic , strong)UILabel *freightLabel;
/** 有无货状态 */
@property(nonatomic , strong)UILabel *kplLabel;

@end

@implementation GoodsDetailFreightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc] init];
        [label setFont:KFont(13)];
        [label setTextColor:KUIColorFromHex(0x999999)];
        [label setText:@"运费"];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(30);
        }];
        
        [self.contentView addSubview:self.freightLabel];
        [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(label.mas_right).offset(10);
        }];
        
        [self.contentView addSubview:self.kplLabel];
        [self.kplLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}

- (void)setJdGoodsModel:(GoodsDetailResultJDGoodsModel *)jdGoodsModel {
    _jdGoodsModel = jdGoodsModel;
    [self.freightLabel setText:[NSString stringWithFormat:@"%.2lf",[_jdGoodsModel.jd_freight floatValue]]];
    [self.kplLabel setText:_jdGoodsModel.kpl];
}

- (void)setFreight:(NSString *)freight {
    _freight = freight;
    if ([_freight floatValue] > 0) {
        [self.freightLabel setText:[NSString stringWithFormat:@"%.2lf",[_freight floatValue]]];
    } else {
        [self.freightLabel setText:_freight];
    }
}

#pragma mark - lazy
- (UILabel *)freightLabel {
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc] init];
        [_freightLabel setTextColor:KUIColorFromHex(0x333333)];
        [_freightLabel setFont:KFont(13)];
    }
    return _freightLabel;
}

- (UILabel *)kplLabel {
    if (!_kplLabel) {
        _kplLabel = [[UILabel alloc] init];
        [_kplLabel setTextColor:KRedColor];
        [_kplLabel setFont:KFont(13)];
    }
    return _kplLabel;
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
