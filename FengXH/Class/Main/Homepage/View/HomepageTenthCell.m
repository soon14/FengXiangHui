//
//  HomepageTenthCell.m
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageTenthCell.h"

@implementation HomepageTenthCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(113*KScreenRatio);
        }];
        
        [self addSubview:self.goodsTitleLabel];
        [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goodsImageView.mas_bottom).offset(5);
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
        }];
        
        [self addSubview:self.originPriceLabel];
        [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goodsTitleLabel.mas_bottom).offset(5);
            make.left.mas_offset(10);
        }];
        
        [self addSubview:self.nowPriceLabel];
        [self.nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.originPriceLabel.mas_bottom).offset(5);
            make.left.mas_offset(10);
        }];
        
        [self addSubview:self.cartButton];
        [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-5);
            make.bottom.mas_offset(-10);
            make.width.height.mas_equalTo(28);
        }];
        
    }
    return self;
}

#pragma mark - 购物车方法
- (void)cartButtonAction:(UIButton *)sender {
    if (self.cellCartBlock) {
        self.cellCartBlock();
    }
}


- (void)setGoodsModel:(HomepageDataGuessYouLikeGoodsDataModel *)goodsModel {
    _goodsModel = goodsModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_goodsModel.thumb]];
    [self.goodsTitleLabel setText:_goodsModel.title];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价¥%@",goodsModel.productprice]];
    [attString addAttributes:@{NSFontAttributeName:KFont(13), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSStrikethroughColorAttributeName:[UIColor lightGrayColor], NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(2, goodsModel.productprice.length+1)];
    [self.originPriceLabel setAttributedText:attString];
    [self.nowPriceLabel setText:[NSString stringWithFormat:@"¥%@",goodsModel.price]];
    
}

#pragma mark - lazy
- (UIButton *)cartButton {
    if (!_cartButton) {
        _cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cartButton setImage:[UIImage imageNamed:@"home_goods_cart"] forState:UIControlStateNormal];
        [_cartButton addTarget:self action:@selector(cartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cartButton;
}

- (UILabel *)nowPriceLabel {
    if (!_nowPriceLabel) {
        _nowPriceLabel = [[UILabel alloc] init];
        [_nowPriceLabel setTextColor:KRedColor];
        [_nowPriceLabel setFont:KFont(13)];
        [_nowPriceLabel setAdjustsFontSizeToFitWidth:YES];
//        [_nowPriceLabel setText:@"¥450"];
    }
    return _nowPriceLabel;
}

- (UILabel *)originPriceLabel {
    if (!_originPriceLabel) {
        _originPriceLabel = [[UILabel alloc] init];
        [_originPriceLabel setTextColor:KUIColorFromHex(0x999999)];
        [_originPriceLabel setFont:KFont(13)];
        [_originPriceLabel setAdjustsFontSizeToFitWidth:YES];
//        [_originPriceLabel setText:@"原价¥321"];
    }
    return _originPriceLabel;
}

- (UILabel *)goodsTitleLabel {
    if (!_goodsTitleLabel) {
        _goodsTitleLabel = [[UILabel alloc] init];
        [_goodsTitleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsTitleLabel setFont:KFont(14)];
        [_goodsTitleLabel setAdjustsFontSizeToFitWidth:YES];
        [_goodsTitleLabel setNumberOfLines:2];
//        [_goodsTitleLabel setText:@"维他奶 原味豆奶植物蛋白饮料..."];
    }
    return _goodsTitleLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
}

@end
