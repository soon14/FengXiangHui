//
//  IntegralRecordDetailStatusCell.m
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordDetailStatusCell.h"
#import "IntegralRecordDetailResultModel.h"

@interface IntegralRecordDetailStatusCell ()

/** 状态 */
@property(nonatomic , strong)UILabel *statusLabel;
/** 价格 */
@property(nonatomic , strong)UILabel *priceLabel;
/** 运费 */
@property(nonatomic , copy)NSString *freightString;

@end

@implementation IntegralRecordDetailStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor orangeColor];
        
        [self.contentView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_offset(20);
            make.right.mas_offset(-10);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_statusLabel.mas_left);
            make.right.mas_equalTo(_statusLabel.mas_right);
            make.top.mas_equalTo(_statusLabel.mas_bottom).offset(5);
        }];
        
    }
    return self;
}

- (void)setStatusModel:(IntegralRecordDetailResultModel *)statusModel {
    _statusModel = statusModel;
    [self.statusLabel setText:_statusModel.statust];
    
    if ([_statusModel.dispatch floatValue] > 0) {
        self.freightString = [NSString stringWithFormat:@"运费：%.2lf",[_statusModel.dispatch floatValue]];
    } else {
        self.freightString = @"免运费";
    }
    
    if ([_statusModel.goods.money floatValue] > 0) {
        [self.priceLabel setText:[NSString stringWithFormat:@"商品总额：%ld 积分 + ¥%.2lf\t\t\t%@",(long)[_statusModel.goods.credit integerValue],[_statusModel.goods.money floatValue],self.freightString]];
    } else {
        [self.priceLabel setText:[NSString stringWithFormat:@"商品总额：%ld 积分\t\t\t%@",(long)[_statusModel.goods.credit integerValue],self.freightString]];
    }
    
    
}


#pragma mark - lazy
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor:[UIColor whiteColor]];
        [_priceLabel setFont:KFont(14)];
    }
    return _priceLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        [_statusLabel setTextColor:[UIColor whiteColor]];
        [_statusLabel setFont:KFont(17)];
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
