//
//  GoodsDetailMemberLevelCell.m
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/14.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailMemberLevelCell.h"
#import "GoodsDetailResultModel.h"

@interface GoodsDetailMemberLevelCell ()

/** 等级 */
@property(nonatomic , strong)UILabel *levelLabel;
/** 优惠价 */
@property(nonatomic , strong)UILabel *priceLabel;

@end

@implementation GoodsDetailMemberLevelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:KUIColorFromHex(0x999999)];
        [label setFont:KFont(13)];
        [label setText:@"会员"];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.levelLabel];
        [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_right).offset(30);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(18);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_levelLabel.mas_right).offset(5);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}

- (void)setMemberLevelModel:(GoodsDetailResultMember_levelModel *)memberLevelModel {
    _memberLevelModel = memberLevelModel;
    [self.levelLabel setText:[NSString stringWithFormat:@"\t\t%@\t\t",_memberLevelModel.level]];
    NSMutableAttributedString *astring = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"可享受 ¥%@ 的价格",_memberLevelModel.memberprice]];
    [astring addAttributes:@{NSForegroundColorAttributeName:KRedColor} range:NSMakeRange(4, _memberLevelModel.memberprice.length+1)];
    [self.priceLabel setAttributedText:astring];
}


#pragma mark - lazy
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor:KUIColorFromHex(0x999999)];
        [_priceLabel setFont:KFont(13)];
    }
    return _priceLabel;
}

- (UILabel *)levelLabel {
    if (!_levelLabel) {
        _levelLabel = [[UILabel alloc] init];
        [_levelLabel setTextColor:KRedColor];
        [_levelLabel setTextAlignment:NSTextAlignmentCenter];
        [_levelLabel setFont:KFont(11)];
        [_levelLabel.layer setMasksToBounds:YES];
        [_levelLabel.layer setCornerRadius:2];
        [_levelLabel.layer setBorderColor:KRedColor.CGColor];
        [_levelLabel.layer setBorderWidth:1];
    }
    return _levelLabel;
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
