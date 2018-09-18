//
//  GoodsDetailFreightCell.m
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailFreightCell.h"

@interface GoodsDetailFreightCell ()

/** 运费 */
@property(nonatomic , strong)UILabel *freightLabel;

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
        
    }
    return self;
}

- (void)setFreight:(NSString *)freight {
    _freight = freight;
    [self.freightLabel setText:_freight];
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
