//
//  GoodsListCollectionCell.m
//  FengXH
//
//  Created by sun on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsListCollectionCell.h"
#import "GoodsListModel.h"

@interface GoodsListCollectionCell()

@property(nonatomic , strong)UIImageView *listTImageView;
@property(nonatomic , strong)UILabel *listTTitleLabel;
@property(nonatomic , strong)UILabel *listTPriceLabel;
@property(nonatomic , strong)UIButton *listTBuyButton;

@end

@implementation GoodsListCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.listTImageView];
        [self.listTImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(180*KScreenRatio);
        }];
        
        
        
        [self addSubview:self.listTTitleLabel];
        [self.listTTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(13);
            make.right.mas_offset(-13);
            make.bottom.mas_offset(-40);
            make.height.mas_equalTo(40);
        }];
        
        
        [self addSubview:self.listTPriceLabel];
        [self.listTPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(13);
            make.right.mas_offset(-45);
            make.bottom.mas_offset(-15);
            make.height.mas_equalTo(15);
        }];
        
        [self addSubview:self.listTBuyButton];
        [self.listTBuyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-13);
            make.centerY.mas_equalTo(_listTPriceLabel.mas_centerY);
            make.height.mas_equalTo(20);
        }];
        
    }
    return self;
}

- (void)setGoodsListCommodityModel:(GoodsListCommodityModel *)goodsListCommodityModel {
    _goodsListCommodityModel = goodsListCommodityModel;
    [self.listTImageView setYy_imageURL:[NSURL URLWithString:_goodsListCommodityModel.thumb]];
    [self.listTTitleLabel setText:_goodsListCommodityModel.title];
    [self.listTPriceLabel setText:[NSString stringWithFormat:@"¥ %@",_goodsListCommodityModel.marketprice]];
}

#pragma mark - 购物车方法
- (void)cartButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsListCollectionCell:didSelectShoppingCartWith:)]) {
        [self.delegate GoodsListCollectionCell:self didSelectShoppingCartWith:self.goodsListCommodityModel];
    }
}

#pragma mark - lazy
- (UIImageView *)listTImageView{
    if (!_listTImageView) {
        _listTImageView = [[UIImageView alloc]init];
        [_listTImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _listTImageView;
}

- (UILabel *)listTTitleLabel{
    if (!_listTTitleLabel) {
        _listTTitleLabel = [[UILabel alloc]init];
        [_listTTitleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_listTTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_listTTitleLabel setFont:KFont(14)];
        _listTTitleLabel.numberOfLines = 2;
    }
    return _listTTitleLabel;
}

- (UILabel *)listTPriceLabel{
    if (!_listTPriceLabel) {
        _listTPriceLabel = [[UILabel alloc]init];
        [_listTPriceLabel setTextColor:KRedColor];
        [_listTPriceLabel setTextAlignment:NSTextAlignmentLeft];
        [_listTPriceLabel setFont:KFont(15)];
        
    }
    return _listTPriceLabel;
}

- (UIButton *)listTBuyButton {
    if (!_listTBuyButton) {
        _listTBuyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listTBuyButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_listTBuyButton.titleLabel setFont:KFont(14)];
        [_listTBuyButton setTitle:@"购买" forState:UIControlStateNormal];
        [_listTBuyButton addTarget:self action:@selector(cartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _listTBuyButton;
}


@end
