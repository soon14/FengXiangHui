//
//  IntegralRecordCell.m
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordCell.h"
#import "IntegralRecordResultModel.h"

@interface IntegralRecordCell ()

/** 订单号 */
@property(nonatomic , strong)UILabel *orderNoLabel;
/** 状态 */
@property(nonatomic , strong)UILabel *statusLabel;
/** 商品图 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 商品名 */
@property(nonatomic , strong)UILabel *goodsNameLabel;
/** 积分 */
@property(nonatomic , strong)UILabel *integralLabel;

@end

@implementation IntegralRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.orderNoLabel];
        [self.orderNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.mas_offset(10);
            make.height.mas_equalTo(35);
        }];
        
        [self.contentView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(35);
        }];
        
        UIView *goodsBackView = [[UIView alloc] init];
        [goodsBackView setBackgroundColor:KTableBackgroundColor];
        [self.contentView addSubview:goodsBackView];
        [goodsBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_orderNoLabel.mas_bottom);
            make.left.right.mas_offset(0);
            make.height.mas_equalTo(80);
        }];
        
        [goodsBackView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.mas_equalTo(goodsBackView.mas_centerY);
            make.width.height.mas_equalTo(60);
        }];
        
        [goodsBackView addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsImageView.mas_right).offset(10);
            make.top.mas_equalTo(_goodsImageView.mas_top);
            make.bottom.mas_equalTo(_goodsImageView.mas_bottom);
            make.right.mas_offset(-10);
        }];
        
        [self.contentView addSubview:self.integralLabel];
        [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(goodsBackView.mas_bottom);
            make.right.mas_offset(-10);
            make.bottom.mas_offset(0);
        }];
        
    }
    return self;
}

- (void)setRecordListModel:(IntegralRecordResultListModel *)recordListModel {
    _recordListModel = recordListModel;
    [self.orderNoLabel setText:[NSString stringWithFormat:@"订单号：%@",_recordListModel.logno]];
    [self.statusLabel setText:_recordListModel.statust];
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_recordListModel.thumb]];
    [self.goodsNameLabel setText:_recordListModel.title];
    if ([_recordListModel.money floatValue] > 0) {
        [self.integralLabel setText:[NSString stringWithFormat:@"%ld 积分 + ¥%.2lf",(long)[_recordListModel.credit integerValue],[recordListModel.money floatValue]]];
    } else {
        [self.integralLabel setText:[NSString stringWithFormat:@"%ld 积分",(long)[_recordListModel.credit integerValue]]];
    }
    
}


#pragma mark - lazy
- (UILabel *)integralLabel {
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc] init];
        [_integralLabel setTextColor:KRedColor];
        [_integralLabel setFont:KFont(15)];
        [_integralLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _integralLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(15)];
        [_goodsNameLabel setNumberOfLines:3];
    }
    return _goodsNameLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        [_statusLabel setTextColor:KRedColor];
        [_statusLabel setFont:KFont(12)];
        [_statusLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _statusLabel;
}

- (UILabel *)orderNoLabel {
    if (!_orderNoLabel) {
        _orderNoLabel = [[UILabel alloc] init];
        [_orderNoLabel setTextColor:KUIColorFromHex(0x333333)];
        [_orderNoLabel setFont:KFont(13)];
    }
    return _orderNoLabel;
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
