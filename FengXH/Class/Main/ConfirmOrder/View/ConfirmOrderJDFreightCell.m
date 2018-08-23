//
//  ConfirmOrderJDFreightCell.m
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderJDFreightCell.h"
#import "ConfirmOrderCreatResultModel.h"

@interface ConfirmOrderJDFreightCell ()

/** 京东运费 */
@property(nonatomic , strong)UILabel *freightLabel;

@end

@implementation ConfirmOrderJDFreightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KRedColor];
        [label setFont:KFont(14)];
        [label setText:@"京东运费"];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.freightLabel];
        [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}

- (void)setResultModel:(ConfirmOrderCreatResultModel *)resultModel {
    _resultModel = resultModel;
    if ([_resultModel.jd_freight integerValue] == 0) {
        [self.freightLabel setText:@"包邮"];
    } else {
        [self.freightLabel setText:[NSString stringWithFormat:@"¥ %@",_resultModel.jd_freight]];
    }
}

#pragma mark - lazy
- (UILabel *)freightLabel {
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc] init];
        [_freightLabel setTextColor:KRedColor];
        [_freightLabel setFont:KFont(14)];
        [_freightLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _freightLabel;
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
