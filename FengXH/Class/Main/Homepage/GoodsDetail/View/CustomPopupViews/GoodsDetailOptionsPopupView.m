//
//  GoodsDetailCartPopupView.m
//  FengXH
//
//  Created by sun on 2018/9/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailOptionsPopupView.h"
#import "GoodsDetailResultModel.h"

@interface GoodsDetailOptionsPopupView ()

/** 商品图 */
@property(nonatomic , strong)UIImageView *goodsIcon;
/** 商品编号 */
@property(nonatomic , strong)UILabel *goodssnLabel;
/** 商品价格 */
@property(nonatomic , strong)UILabel *goodsPriceLabel;
/** 收起按钮 */
@property(nonatomic , strong)UIButton *backButton;
/** 确定按钮 */
@property(nonatomic , strong)UIButton *confirmButton;

@end

@implementation GoodsDetailOptionsPopupView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.contentHeight = 500 + KBottomHeight;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.goodsIcon];
        [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(20);
            make.width.height.mas_equalTo(100);
        }];
        
        [self.contentView addSubview:self.goodssnLabel];
        [self.goodssnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_goodsIcon.mas_bottom);
            make.left.mas_equalTo(_goodsIcon.mas_right).offset(20);
            make.height.mas_equalTo(15);
        }];
        
        [self.contentView addSubview:self.goodsPriceLabel];
        [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsIcon.mas_right).offset(20);
            make.bottom.mas_equalTo(_goodssnLabel.mas_top).offset(-10);
        }];
        
        [self.contentView addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.right.mas_offset(-15);
            make.width.height.mas_equalTo(25);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(_goodsIcon.mas_bottom).offset(20);
            make.height.mas_equalTo(0.5);
        }];
        
        
    }
    return self;
}

- (void)setGoodsDetailResultModel:(GoodsDetailResultModel *)goodsDetailResultModel {
    _goodsDetailResultModel = goodsDetailResultModel;
    [self.goodsIcon setYy_imageURL:[NSURL URLWithString:_goodsDetailResultModel.thumb]];
    if (_goodsDetailResultModel.goodssn && _goodsDetailResultModel.goodssn.length > 0) {
        [self.goodssnLabel setText:[NSString stringWithFormat:@"商品编号：%@",_goodsDetailResultModel.goodssn]];
    }
    [self.goodsPriceLabel setText:[NSString stringWithFormat:@"¥%@",_goodsDetailResultModel.marketprice]];
    
}


#pragma mark - 收起
- (void)backButtonAction:(UIButton *)sender {
    [self removeView];
}

#pragma mark - 确定
- (void)confirmButtonAction:(UIButton *)sender {
    
}


#pragma mark - lazy

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setBackgroundColor:KRedColor];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:KFont(14)];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UILabel *)goodsPriceLabel {
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] init];
        [_goodsPriceLabel setTextColor:KRedColor];
        [_goodsPriceLabel setFont:[UIFont boldSystemFontOfSize:20]];
    }
    return _goodsPriceLabel;
}

- (UILabel *)goodssnLabel {
    if (!_goodssnLabel) {
        _goodssnLabel = [[UILabel alloc] init];
        [_goodssnLabel setTextColor:KUIColorFromHex(0x999999)];
        [_goodssnLabel setFont:KFont(12)];
    }
    return _goodssnLabel;
}

- (UIImageView *)goodsIcon {
    if (!_goodsIcon) {
        _goodsIcon = [[UIImageView alloc] init];
//        [_goodsIcon setBackgroundColor:KTableBackgroundColor];
    }
    return _goodsIcon;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
