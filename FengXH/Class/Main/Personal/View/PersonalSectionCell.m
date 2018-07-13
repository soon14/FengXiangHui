//
//  PersonalSectionCell.m
//  FengXH
//
//  Created by sun on 2018/7/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalSectionCell.h"

@implementation PersonalSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.titleImageView];
        [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(13);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(20);
        }];

        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.moreLabel];
        [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-0);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}


#pragma mark - lazy
- (UILabel *)moreLabel {
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc] init];
        [_moreLabel setTextColor:KUIColorFromHex(0x999999)];
        [_moreLabel setFont:KFont(15)];
        [_moreLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _moreLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_titleLabel setFont:KFont(15)];
    }
    return _titleLabel;
}

- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc] init];
    }
    return _titleImageView;
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
