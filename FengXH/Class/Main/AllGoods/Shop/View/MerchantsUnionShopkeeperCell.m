//
//  MerchantsUnionShopkeeperCell.m
//  FengXH
//
//  Created by sun on 2018/9/25.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "MerchantsUnionShopkeeperCell.h"
#import "GoodsDetailResultModel.h"
#import "UnionMerchantResultModel.h"

@interface MerchantsUnionShopkeeperCell ()

@property(nonatomic , strong)UIImageView *shopkeeperIcon;
@property(nonatomic , strong)UILabel *shopkeeperNameLabel;
@property(nonatomic , strong)UILabel *shopDescriptionLabel;

@end

@implementation MerchantsUnionShopkeeperCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.shopkeeperIcon];
        [self.shopkeeperIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(15);
            make.left.mas_offset(20);
            make.width.height.mas_equalTo(50);
        }];
        
        [self.contentView addSubview:self.shopkeeperNameLabel];
        [self.shopkeeperNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_shopkeeperIcon.mas_right).offset(20);
            make.right.mas_offset(-20);
            make.bottom.mas_equalTo(_shopkeeperIcon.mas_centerY);
        }];
        
        [self.contentView addSubview:self.shopDescriptionLabel];
        [self.shopDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_shopkeeperNameLabel.mas_left);
            make.right.mas_offset(-20);
            make.top.mas_equalTo(_shopkeeperNameLabel.mas_bottom).offset(5);
        }];
    }
    return self;
}

- (void)setShopDetailModel:(GoodsDetailResultShopdetailModel *)shopDetailModel {
    _shopDetailModel = shopDetailModel;
    [self.shopkeeperIcon setYy_imageURL:[NSURL URLWithString:_shopDetailModel.logo]];
    if (_shopDetailModel.shopname && shopDetailModel.shopname.length > 0) {
        [self.shopkeeperNameLabel setText:_shopDetailModel.shopname];
    }
    if (_shopDetailModel.shopDescription && _shopDetailModel.shopDescription.length > 0) {
        [self.shopDescriptionLabel setText:_shopDetailModel.shopDescription];
    }
}

- (void)setUnionMerchantModel:(UnionMerchantResultItemsItemsModel *)unionMerchantModel {
    _unionMerchantModel = unionMerchantModel;
    [self.shopkeeperIcon setYy_imageURL:[NSURL URLWithString:_unionMerchantModel.thumb]];
    if (_unionMerchantModel.name && _unionMerchantModel.name.length > 0) {
        [self.shopkeeperNameLabel setText:_unionMerchantModel.name];
    }
    if (_unionMerchantModel.desc && _unionMerchantModel.desc.length > 0) {
        [self.shopDescriptionLabel setText:_unionMerchantModel.desc];
    }
}


#pragma mark - lazy
- (UILabel *)shopDescriptionLabel {
    if (!_shopDescriptionLabel) {
        _shopDescriptionLabel = [[UILabel alloc] init];
        [_shopDescriptionLabel setTextColor:KUIColorFromHex(0x999999)];
        [_shopDescriptionLabel setFont:KFont(12)];
    }
    return _shopDescriptionLabel;
}

- (UILabel *)shopkeeperNameLabel {
    if (!_shopkeeperNameLabel) {
        _shopkeeperNameLabel = [[UILabel alloc] init];
        [_shopkeeperNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_shopkeeperNameLabel setFont:KFont(18)];
    }
    return _shopkeeperNameLabel;
}

- (UIImageView *)shopkeeperIcon {
    if (!_shopkeeperIcon) {
        _shopkeeperIcon = [[UIImageView alloc] init];
        [_shopkeeperIcon.layer setMasksToBounds:YES];
        [_shopkeeperIcon.layer setCornerRadius:25];
        [_shopkeeperIcon setBackgroundColor:KTableBackgroundColor];
    }
    return _shopkeeperIcon;
}




@end
