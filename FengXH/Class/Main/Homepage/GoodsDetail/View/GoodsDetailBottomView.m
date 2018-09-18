//
//  GoodsDetailBottomView.m
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailBottomView.h"

@interface GoodsDetailBottomView ()

/** 收藏 */
@property(nonatomic , strong)UIButton *collecButton;
/** 店铺 */
@property(nonatomic , strong)UIButton *storeButton;
/** 跳转至购物车 */
@property(nonatomic , strong)UIButton *shopCartButton;
/** 加入购物车 */
@property(nonatomic , strong)UIButton *addToShpCartButton;
/** 立即购买 */
@property(nonatomic , strong)UIButton *buyNowButton;

@end

@implementation GoodsDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat buttonHeight = 45;
        
        [self addSubview:self.buyNowButton];
        [self.buyNowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(0);
            make.width.mas_equalTo(110*KScreenRatio);
            make.height.mas_equalTo(buttonHeight);
        }];
        
        [self addSubview:self.addToShpCartButton];
        [self.addToShpCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_equalTo(_buyNowButton.mas_left);
            make.width.mas_equalTo(110*KScreenRatio);
            make.height.mas_equalTo(buttonHeight);
        }];
        
        CGFloat buttonWidth = (KMAINSIZE.width-220*KScreenRatio)/3;
        
        [self addSubview:self.collecButton];
        [self.collecButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(0);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(buttonHeight);
        }];
        
        [self addSubview:self.storeButton];
        [self.storeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.mas_equalTo(_collecButton.mas_right);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(buttonHeight);
        }];
        
        [self addSubview:self.shopCartButton];
        [self.shopCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.mas_equalTo(_storeButton.mas_right);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(buttonHeight);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailBottomView:buttonAction:)]) {
        [self.delegate GoodsDetailBottomView:self buttonAction:sender.tag];
    }
}


#pragma mark - lazy
- (UIButton *)buyNowButton {
    if (!_buyNowButton) {
        _buyNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyNowButton setBackgroundColor:KRedColor];
        [_buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyNowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyNowButton.titleLabel setFont:KFont(13)];
        [_buyNowButton setTag:4];
        [_buyNowButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyNowButton;
}

- (UIButton *)addToShpCartButton {
    if (!_addToShpCartButton) {
        _addToShpCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addToShpCartButton setBackgroundColor:KUIColorFromHex(0xF5A418)];
        [_addToShpCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addToShpCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addToShpCartButton.titleLabel setFont:KFont(13)];
        [_addToShpCartButton setTag:3];
        [_addToShpCartButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addToShpCartButton;
}

- (UIButton *)shopCartButton {
    if (!_shopCartButton) {
        _shopCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shopCartButton setImage:[UIImage imageNamed:@"goodsDetailToShopCart"] forState:UIControlStateNormal];
        [_shopCartButton setTag:2];
        [_shopCartButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopCartButton;
}

- (UIButton *)storeButton {
    if (!_storeButton) {
        _storeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_storeButton setImage:[UIImage imageNamed:@"goodsDetailStore"] forState:UIControlStateNormal];
        [_storeButton setTag:1];
        [_storeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _storeButton;
}

- (UIButton *)collecButton {
    if (!_collecButton) {
        _collecButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collecButton setImage:[UIImage imageNamed:@"goodsDetailCollect"] forState:UIControlStateNormal];
        [_collecButton setTag:0];
        [_collecButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collecButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
