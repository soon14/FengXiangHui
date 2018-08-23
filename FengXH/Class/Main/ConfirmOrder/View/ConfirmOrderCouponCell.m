//
//  ConfirmOrderCouponCell.m
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderCouponCell.h"
#import "ConfirmOrderCreatResultModel.h"

@interface ConfirmOrderCouponCell ()

/** 数量 */
@property(nonatomic , strong)UILabel *countLabel;

@end

@implementation ConfirmOrderCouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KUIColorFromHex(0x666666)];
        [label setFont:KFont(14)];
        [label setText:@"优惠券"];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-0);
            make.height.mas_equalTo(24);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}

- (void)setResultModel:(ConfirmOrderCreatResultModel *)resultModel {
    _resultModel = resultModel;
    [self.countLabel setText:[NSString stringWithFormat:@"   %ld   ",(long)_resultModel.couponcount]];
}


#pragma mark - lazy
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        [_countLabel setTextColor:[UIColor whiteColor]];
        [_countLabel setBackgroundColor:KRedColor];
        [_countLabel setFont:KFont(14)];
        [_countLabel.layer setMasksToBounds:YES];
        [_countLabel.layer setCornerRadius:12];
    }
    return _countLabel;
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
