//
//  SignInDetailCell.m
//  FengXH
//
//  Created by sun on 2018/10/8.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "SignInDetailCell.h"
#import "SignInDetailResultModel.h"

@interface SignInDetailCell ()

/** 描述 */
@property(nonatomic , strong)UILabel *descriptionLabel;
/** 类型 */
@property(nonatomic , strong)UILabel *typeLabel;
/** 时间 */
@property(nonatomic , strong)UILabel *timeLabel;
/** 积分 */
@property(nonatomic , strong)UILabel *creditLabel;

@end

@implementation SignInDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.descriptionLabel];
        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(20);
            make.left.mas_offset(15);
        }];
        
        [self.contentView addSubview:self.typeLabel];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_descriptionLabel.mas_left);
            make.bottom.mas_offset(-20);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(60);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_typeLabel.mas_right).offset(10);
            make.centerY.mas_equalTo(_typeLabel.mas_centerY);
        }];
        
        [self.contentView addSubview:self.creditLabel];
        [self.creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}

- (void)setSignInDetailModel:(SignInDetailResultListModel *)signInDetailModel {
    _signInDetailModel = signInDetailModel;
    [self.descriptionLabel setText:_signInDetailModel.log];
    
    if (_signInDetailModel.type == 0) {
        [self.typeLabel setText:@"日常签到"];
    } else if (_signInDetailModel.type == 1) {
        [self.typeLabel setText:@"连续签到"];
    } else if (_signInDetailModel.type == 2) {
        [self.typeLabel setText:@"总签到"];
    } else {
        [self.typeLabel setText:@"其他"];
    }
    
    [self.timeLabel setText:_signInDetailModel.date];
    
    [self.creditLabel setText:[NSString stringWithFormat:@"+%ld",(long)_signInDetailModel.credit]];
}

#pragma mark - lazy
- (UILabel *)creditLabel {
    if (!_creditLabel) {
        _creditLabel = [[UILabel alloc] init];
        [_creditLabel setTextColor:KRedColor];
        [_creditLabel setFont:KFont(15)];
        [_creditLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _creditLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setTextColor:KUIColorFromHex(0x999999)];
        [_timeLabel setFont:KFont(12)];
    }
    return _timeLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        [_typeLabel setBackgroundColor:KRedColor];
        [_typeLabel setTextColor:[UIColor whiteColor]];
        [_typeLabel setFont:KFont(12)];
        [_typeLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _typeLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        [_descriptionLabel setTextColor:KUIColorFromHex(0x333333)];
        [_descriptionLabel setFont:KFont(14)];
    }
    return _descriptionLabel;
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
