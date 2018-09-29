//
//  IntegralMallCell.m
//  FengXH
//
//  Created by  on 2018/9/27.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralMallGoodsCell.h"
#import "IntegralMallResultModel.h"

@interface IntegralMallGoodsCell ()

/** 商品图片 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 商品名 */
@property(nonatomic , strong)UILabel *goodsNameLabel;
/** 积分 */
@property(nonatomic , strong)UILabel *integralPriceLabel;

@end

@implementation IntegralMallGoodsCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(15);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.height.mas_equalTo(KMAINSIZE.width/2);
        }];
        
        [self addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(15);
            make.left.mas_offset(15);
            make.right.mas_offset(-15);
            make.height.mas_equalTo(40);
        }];
        
        [self addSubview:self.integralPriceLabel];
        [self.integralPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsNameLabel.mas_left);
            make.right.mas_equalTo(_goodsNameLabel.mas_right);
            make.top.mas_equalTo(_goodsNameLabel.mas_bottom).offset(0);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:[UIColor whiteColor]];
        [label setBackgroundColor:KRedColor];
        [label setFont:KFont(11)];
        [label setText:@"兑换"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label.layer setMasksToBounds:YES];
        [label.layer setCornerRadius:8];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsNameLabel.mas_left);
            make.bottom.mas_offset(-15);
            make.width.mas_equalTo(36);
            make.height.mas_equalTo(16);
        }];
        
    }
    return self;
}

- (void)setIntegralGoodsModel:(IntegralMallResultItemsGoodsModel *)integralGoodsModel {
    _integralGoodsModel = integralGoodsModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_integralGoodsModel.thumb]];
    [self.goodsNameLabel setText:_integralGoodsModel.title];
    if ([_integralGoodsModel.price floatValue] > 0) {
        NSString *creditString = [NSString stringWithFormat:@"%ld",(long)_integralGoodsModel.credit];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分 + ¥%.2lf",creditString,[_integralGoodsModel.price floatValue]]];
        [attributedString addAttributes:@{NSFontAttributeName:KFont(12)} range:NSMakeRange(creditString.length, 2)];
        NSRange range = [[NSString stringWithFormat:@"%@积分 + ¥%.2lf",creditString,[_integralGoodsModel.price floatValue]] rangeOfString:@"¥"];
        [attributedString addAttributes:@{NSFontAttributeName:KFont(15)} range:range];
        [self.integralPriceLabel setAttributedText:attributedString];
    } else {
        NSString *creditString = [NSString stringWithFormat:@"%ld",(long)_integralGoodsModel.credit];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分",creditString]];
        [attributedString addAttributes:@{NSFontAttributeName:KFont(12)} range:NSMakeRange(creditString.length, 2)];
        [self.integralPriceLabel setAttributedText:attributedString];
    }
}

#pragma mark - lazy

- (UILabel *)integralPriceLabel {
    if (!_integralPriceLabel) {
        _integralPriceLabel = [[UILabel alloc] init];
        [_integralPriceLabel setTextColor:KRedColor];
        [_integralPriceLabel setFont:KFont(20)];
        [_integralPriceLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _integralPriceLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(15)];
        [_goodsNameLabel setNumberOfLines:2];
    }
    return _goodsNameLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        
    }
    return _goodsImageView;
}

@end
