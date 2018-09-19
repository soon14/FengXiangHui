//
//  GoodsDetailCountCell.m
//  FengXH
//
//  Created by sun on 2018/9/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailCountCell.h"

@interface GoodsDetailCountCell ()

/** countLabel */
@property(nonatomic , strong)UILabel *countLabel;

@end

@implementation GoodsDetailCountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *moreImageV = [[UIImageView alloc] init];
        [moreImageV setImage:[UIImage imageNamed:@"GoodsDetailMore"]];
        [self.contentView addSubview:moreImageV];
        [moreImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(15);
        }];
        
        [self.contentView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.right.mas_equalTo(moreImageV.mas_left).offset(-10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
    }
    return self;
}

#pragma mark - lazy
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        [_countLabel setTextColor:KUIColorFromHex(0x333333)];
        [_countLabel setFont:KFont(13)];
        [_countLabel setText:@"请选择数量"];
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
