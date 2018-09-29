//
//  IntegralExchangeListCell.m
//  FengXH
//
//  Created by  on 2018/9/27.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralExchangeListCell.h"
#import "IntegralExchangeResultModel.h"

@interface IntegralExchangeListCell ()

/** 图 */
@property(nonatomic , strong)UIImageView *listImageView;
/** title */
@property(nonatomic , strong)UILabel *titleLabel;
/** 积分 */
@property(nonatomic , strong)UILabel *integralLabel;
/** time */
@property(nonatomic , strong)UILabel *timeLabel;

@end

@implementation IntegralExchangeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.listImageView];
        [self.listImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(50);
        }];

        [self.contentView addSubview:self.integralLabel];
        [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(65);
        }];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_listImageView.mas_right).offset(20);
            make.right.mas_equalTo(_integralLabel.mas_left).offset(-10);
            make.bottom.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel.mas_left);
            make.right.mas_equalTo(_titleLabel.mas_right);
            make.bottom.mas_equalTo(_listImageView.mas_bottom);
        }];
        
        
    }
    return self;
}

- (void)setExchangeListModel:(IntegralExchangeResultListModel *)exchangeListModel {
    _exchangeListModel = exchangeListModel;
    [self.listImageView setYy_imageURL:[NSURL URLWithString:_exchangeListModel.thumb]];
    [self.integralLabel setText:[NSString stringWithFormat:@"-%ld积分\n%@",(long)[_exchangeListModel.credit integerValue],_exchangeListModel.statust]];
    [self.titleLabel setText:_exchangeListModel.title];
    [self.timeLabel setText:_exchangeListModel.createtime];
}


#pragma mark - lazy
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setTextColor:KUIColorFromHex(0x666666)];
        [_timeLabel setFont:KFont(12)];
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_titleLabel setFont:KFont(15)];
    }
    return _titleLabel;
}

- (UILabel *)integralLabel {
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc] init];
        [_integralLabel setTextColor:KUIColorFromHex(0x666666)];
        [_integralLabel setFont:KFont(12)];
        [_integralLabel setNumberOfLines:2];
        [_integralLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _integralLabel;
}

- (UIImageView *)listImageView {
    if (!_listImageView) {
        _listImageView = [[UIImageView alloc] init];
        [_listImageView setBackgroundColor:KTableBackgroundColor];
    }
    return _listImageView;
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
