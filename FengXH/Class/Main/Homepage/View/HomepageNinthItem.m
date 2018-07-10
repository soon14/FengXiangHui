//
//  HomepageNinthItem.m
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageNinthItem.h"

@implementation HomepageNinthItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(136*KScreenRatio);
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
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-5);
            make.width.height.mas_equalTo(36);
        }];
        
    }
    return self;
}


#pragma mark - 购物车方法
- (void)cartButtonAction:(UIButton *)sender {
    if (self.ninthItemBlock) {
        self.ninthItemBlock(sender.tag);
    }
}

#pragma mark - lazy
- (UIButton *)cartButton {
    if (!_cartButton) {
        _cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cartButton setTintColor:KRedColor];
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
        [_nowPriceLabel setText:@"¥450"];
    }
    return _nowPriceLabel;
}

- (UILabel *)originPriceLabel {
    if (!_originPriceLabel) {
        _originPriceLabel = [[UILabel alloc] init];
        [_originPriceLabel setTextColor:KUIColorFromHex(0x999999)];
        [_originPriceLabel setFont:KFont(13)];
        [_originPriceLabel setAdjustsFontSizeToFitWidth:YES];
        [_originPriceLabel setText:@"原价¥321"];
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
        [_goodsTitleLabel setText:@"维他奶 原味豆奶植物蛋白饮料..."];
    }
    return _goodsTitleLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
