//
//  GoodsDetailShopCell.m
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailShopCell.h"
#import "GoodsDetailResultModel.h"

@interface GoodsDetailShopCell ()

/** storeIcon */
@property(nonatomic , strong)UIImageView *storeIcon;
/** storeName */
@property(nonatomic , strong)UILabel *storeName;
/** 进入店铺 */
@property(nonatomic , strong)UIButton *enterButton;

@end

@implementation GoodsDetailShopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.storeIcon];
        [self.storeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(40);
        }];
        
        [self.contentView addSubview:self.storeName];
        [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_storeIcon.mas_right).offset(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentView addSubview:self.enterButton];
        [self.enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(24);
            make.width.mas_equalTo(70);
        }];
    }
    return self;
}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailShopCell:buttonAction:)]) {
        [self.delegate GoodsDetailShopCell:self buttonAction:sender];
    }
}

- (void)setShopDetailModel:(GoodsDetailResultShopdetailModel *)shopDetailModel {
    _shopDetailModel = shopDetailModel;
    [self.storeIcon setYy_imageURL:[NSURL URLWithString:_shopDetailModel.logo]];
    [self.storeName setText:_shopDetailModel.shopname];
}

#pragma mark - lazy
- (UIButton *)enterButton {
    if (!_enterButton) {
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_enterButton setTitle:@"进入店铺" forState:UIControlStateNormal];
        [_enterButton setTitleColor:KRedColor forState:UIControlStateNormal];
        [_enterButton.titleLabel setFont:KFont(13)];
        [_enterButton.layer setMasksToBounds:YES];
        [_enterButton.layer setCornerRadius:12];
        [_enterButton.layer setBorderColor:KRedColor.CGColor];
        [_enterButton.layer setBorderWidth:1];
        [_enterButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterButton;
}

- (UILabel *)storeName {
    if (!_storeName) {
        _storeName = [[UILabel alloc] init];
        [_storeName setTextColor:KUIColorFromHex(0x333333)];
        [_storeName setFont:KFont(15)];
    }
    return _storeName;
}

- (UIImageView *)storeIcon {
    if (!_storeIcon) {
        _storeIcon = [[UIImageView alloc] init];
        [_storeIcon setBackgroundColor:KTableBackgroundColor];
        [_storeIcon.layer setMasksToBounds:YES];
        [_storeIcon.layer setCornerRadius:20];
        [_storeIcon setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _storeIcon;
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
