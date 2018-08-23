//
//  FreshCollectionViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "FreshCollectionViewCell.h"
@interface FreshCollectionViewCell()
@property (nonatomic ,strong) UIImageView *image;
@property (nonatomic ,strong) UIImageView *recommendedImg;
@property (nonatomic ,strong) UILabel *title;
@property (nonatomic ,strong) UILabel *price;
@property (nonatomic ,strong) UILabel *buy;
@end
@implementation FreshCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.image];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(5);
            make.right.mas_offset(-5);
            make.height.mas_equalTo(100);
        }];
        [self.image addSubview:self.recommendedImg];
        [self.recommendedImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(0);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);
        }];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5);
            make.right.mas_offset(-5);
            make.top.mas_equalTo(self.image.mas_bottom).offset(15);
            make.height.mas_equalTo(35);
        }];

        [self addSubview:self.price];
        [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5);
            make.bottom.mas_offset(-5);
            make.height.mas_equalTo(20);
        }];
        [self addSubview:self.buy];
        [self.buy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(40);
        }];
    }
    return self;
}
- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
    }
    return _image;
}
- (UIImageView *)recommendedImg{
    if (!_recommendedImg) {
        _recommendedImg = [[UIImageView alloc]init];
    }
    return _recommendedImg;
}
- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = KUIColorFromHex(0x666666);
        _title.font = KFont(12);
        _title.textAlignment = NSTextAlignmentCenter;
        _title.numberOfLines = 0;
    }
    return _title;
}
- (UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc]init];
        _price.textColor = KUIColorFromHex(0xff5555);
        _price.font = KFont(12);
        _price.textAlignment = NSTextAlignmentLeft;
    }
    return _price;
}
- (UILabel *)buy{
    if (!_buy) {
        _buy = [[UILabel alloc]init];
        _buy.textColor = KUIColorFromHex(0xff5555);
        _buy.layer.borderColor = KUIColorFromHex(0xff5555).CGColor;
        _buy.layer.borderWidth = 0.5f;
        _buy.font = KFont(12);
        _buy.text = @"购买";
        _buy.textAlignment = NSTextAlignmentCenter;
    }
    return _buy;
}
- (void)setData:(NSString *)imgStr AndRecommended:(NSString *)recommendStr AndTitle:(NSString *)titleStr AndPrice:(NSString *)price{
    [self.image setYy_imageURL:[NSURL URLWithString:imgStr]];
    [self.recommendedImg setYy_imageURL:[NSURL URLWithString:recommendStr]];
    [self.title setText:titleStr];
    [self.price setText:[NSString stringWithFormat:@"¥%@",price]];
}
@end
