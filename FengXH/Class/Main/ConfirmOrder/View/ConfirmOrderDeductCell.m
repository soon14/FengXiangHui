//
//  ConfirmOrderDeductCell.m
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderDeductCell.h"
#import "ConfirmOrderCreatResultModel.h"

@interface ConfirmOrderDeductCell ()

/** F 币可抵扣 */
@property(nonatomic , strong)UILabel *deductLabel;
/** switch */
@property(nonatomic , strong)UISwitch *deductSwitch;

@end

@implementation ConfirmOrderDeductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.deductLabel];
        [self.deductLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.deductSwitch];
        [self.deductSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}

- (void)setResultModel:(ConfirmOrderCreatResultModel *)resultModel {
    _resultModel = resultModel;
    NSString *fString = [NSString stringWithFormat:@"%.2f",[_resultModel.deductcredit2 floatValue]];
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"F币可抵扣 %@ 元",fString]];
    [aString addAttributes:@{NSForegroundColorAttributeName:KRedColor} range:NSMakeRange(6, fString.length)];
    [self.deductLabel setAttributedText:aString];
    
    
}

#pragma mark - switchAction
- (void)switchAction:(UISwitch *)sender {
    if (self.switchBlock) {
        self.switchBlock(sender);
    }
}

#pragma mark - lazy
- (UISwitch *)deductSwitch {
    if (!_deductSwitch) {
        _deductSwitch = [[UISwitch alloc] init];
        [_deductSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _deductSwitch;
}

- (UILabel *)deductLabel {
    if (!_deductLabel) {
        _deductLabel = [[UILabel alloc] init];
        [_deductLabel setTextColor:KUIColorFromHex(0x666666)];
        [_deductLabel setFont:KFont(14)];
    }
    return _deductLabel;
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
