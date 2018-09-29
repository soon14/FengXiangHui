//
//  IntegralRecordDetailGoodsCell.m
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordDetailGoodsCell.h"
#import "IntegralRecordDetailResultModel.h"

@interface IntegralRecordDetailGoodsCell ()

/** 商品图片 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 积分、价格 */
@property(nonatomic , strong)UILabel *integralLabel;
/** 商品名 */
@property(nonatomic , strong)UILabel *goodsNameLabel;

@end

@implementation IntegralRecordDetailGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(60);
        }];
        
        [self.contentView addSubview:self.integralLabel];
        [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(15);
            make.right.mas_offset(-10);
        }];
        
        [self.contentView addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsImageView.mas_right).offset(10);
            make.top.mas_equalTo(_goodsImageView.mas_top);
            make.right.mas_equalTo(_integralLabel.mas_left).offset(-15);
        }];
        
    }
    return self;
}

- (void)setDetailResultModel:(IntegralRecordDetailResultModel *)detailResultModel {
    _detailResultModel = detailResultModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_detailResultModel.goods.thumb]];
    
    if ([_detailResultModel.goods.money floatValue] > 0) {
        [self.integralLabel setText:[NSString stringWithFormat:@"%ld 积分 + ¥%.2lf",(long)[_detailResultModel.goods.credit integerValue],[_detailResultModel.goods.money floatValue]]];
    } else {
        [self.integralLabel setText:[NSString stringWithFormat:@"%ld 积分",(long)[_detailResultModel.goods.credit integerValue]]];
    }
    
    [self.goodsNameLabel setText:_detailResultModel.goods.title];
}


#pragma mark - lazy
- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(15)];
        [_goodsNameLabel setNumberOfLines:3];
    }
    return _goodsNameLabel;
}

- (UILabel *)integralLabel {
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc] init];
        [_integralLabel setTextColor:KUIColorFromHex(0x666666)];
        [_integralLabel setFont:KFont(14)];
        [_integralLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _integralLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
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
