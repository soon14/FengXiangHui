//
//  UnionMerchantHeaderView.m
//  FengXH
//
//  Created by sun on 2018/10/12.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "UnionMerchantHeaderView.h"
#import "UnionMerchantResultModel.h"

@interface UnionMerchantHeaderView ()

/** imageV */
@property(nonatomic , strong)UIImageView *merchantImageView;
/** 商户名 */
@property(nonatomic , strong)UILabel *merchantNameLabel;
/** 介绍 */
@property(nonatomic , strong)UILabel *subtitleLabel;

@end

@implementation UnionMerchantHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.merchantImageView];
        [self.merchantImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(60);
        }];
        
        [self.contentView addSubview:self.merchantNameLabel];
        [self.merchantNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_merchantImageView.mas_right).offset(10);
            make.top.mas_equalTo(_merchantImageView.mas_top).offset(12);
        }];
        
        [self.contentView addSubview:self.subtitleLabel];
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_merchantNameLabel.mas_left);
            make.top.mas_equalTo(_merchantNameLabel.mas_bottom).offset(5);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.contentView addGestureRecognizer:tap];
        
    }
    return self;
}

#pragma mark - action
- (void)tapAction:(UITapGestureRecognizer *)sender {
    if ([_merchantArray count] > 0) {
        UnionMerchantResultItemsItemsModel *itemsModel = [_merchantArray firstObject];
        if (self.delegate && [self.delegate respondsToSelector:@selector(UnionMerchantHeaderView:didSelectItemWith:)]) {
            [self.delegate UnionMerchantHeaderView:self didSelectItemWith:itemsModel];
        }
    }
}

- (void)setMerchantArray:(NSArray *)merchantArray {
    _merchantArray = merchantArray;
    if ([_merchantArray count] > 0) {
        UnionMerchantResultItemsItemsModel *itemsModel = [_merchantArray firstObject];
        [self.merchantImageView setYy_imageURL:[NSURL URLWithString:itemsModel.thumb]];
        [self.merchantNameLabel setText:itemsModel.name];
        [self.subtitleLabel setText:itemsModel.desc?itemsModel.desc:@""];
    }
}

#pragma mark - lazy
- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        [_subtitleLabel setTextColor:KUIColorFromHex(0x999999)];
        [_subtitleLabel setFont:KFont(13)];
    }
    return _subtitleLabel;
}

- (UILabel *)merchantNameLabel {
    if (!_merchantNameLabel) {
        _merchantNameLabel = [[UILabel alloc] init];
        [_merchantNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_merchantNameLabel setFont:KFont(14)];
    }
    return _merchantNameLabel;
}

- (UIImageView *)merchantImageView {
    if (!_merchantImageView) {
        _merchantImageView = [[UIImageView alloc] init];
        [_merchantImageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _merchantImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
