//
//  ConfirmOrderSelectCouponCell.m
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderSelectCouponCell.h"
#import "ConfirmOrderCouponResultModel.h"

@interface ConfirmOrderSelectCouponCell ()

/** 几折 */
@property(nonatomic , strong)UILabel *backTypeLabel;
/** 内容 */
@property(nonatomic , strong)UILabel *nameLabel;
/** 有效期 */
@property(nonatomic , strong)UILabel *timeLabel;
/** 选择按钮 */
@property(nonatomic , strong)UIButton *selectButton;

@end

@implementation ConfirmOrderSelectCouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
//        UIView *backView = [[UIView alloc] init];
//        [backView setBackgroundColor:[UIColor whiteColor]];
//        [self.contentView addSubview:backView];
//        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_offset(10);
//            make.right.mas_offset(-10);
//            make.top.bottom.mas_offset(0);
//        }];
        
        [self.contentView addSubview:self.backTypeLabel];
        [self.backTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_offset(0);
            make.width.mas_equalTo(100);
        }];
        
        [self.contentView addSubview:self.selectButton];
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(60);
        }];
        
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_backTypeLabel.mas_right).offset(8);
            make.bottom.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(_selectButton.mas_left).offset(8);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLabel.mas_left);
            make.right.mas_equalTo(_nameLabel.mas_right);
            make.top.mas_equalTo(_nameLabel.mas_bottom).offset(5);
        }];
        
    }
    return self;
}

- (void)setCouponModel:(ConfirmOrderCouponResultListModel *)couponModel {
    _couponModel = couponModel;
    [self.backTypeLabel setText:[NSString stringWithFormat:@"%@折",_couponModel.backmoney]];
    [self.nameLabel setText:_couponModel.couponname];
    [self.timeLabel setText:[NSString stringWithFormat:@"有效期：%@",_couponModel.timestr]];
    
    
}

#pragma mark - 选择
- (void)selectButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setBackgroundColor:KRedColor];
    } else {
        [sender setBackgroundColor:[UIColor whiteColor]];
    }
    if (self.couponSelectedBlock) {
        self.couponSelectedBlock(self.couponModel, sender.selected);
    }
}

#pragma mark - lazy
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setTitle:@"选择" forState:UIControlStateNormal];
        [_selectButton setTitle:@"已选择" forState:UIControlStateSelected];
        [_selectButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_selectButton.titleLabel setFont:KFont(14)];
        [_selectButton.layer setBorderColor:KRedColor.CGColor];
        [_selectButton.layer setBorderWidth:1];
        [_selectButton.layer setMasksToBounds:YES];
        [_selectButton.layer setCornerRadius:14];
        [_selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setTextColor:KUIColorFromHex(0x999999)];
        [_timeLabel setFont:KFont(12)];
    }
    return _timeLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_nameLabel setFont:KFont(15)];
    }
    return _nameLabel;
}

- (UILabel *)backTypeLabel {
    if (!_backTypeLabel) {
        _backTypeLabel = [[UILabel alloc] init];
        [_backTypeLabel setBackgroundColor:KRedColor];
        [_backTypeLabel setTextColor:[UIColor whiteColor]];
        [_backTypeLabel setFont:KFont(26)];
        [_backTypeLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _backTypeLabel;
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
