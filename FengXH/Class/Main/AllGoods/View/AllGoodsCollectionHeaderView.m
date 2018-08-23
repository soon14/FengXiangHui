//
//  AllGoodsCollectionHeaderView.m
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AllGoodsCollectionHeaderView.h"

@interface AllGoodsCollectionHeaderView ()

/** 图片 */
@property(nonatomic , strong)UIImageView *adImageView;

@end

@implementation AllGoodsCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.adImageView];
        [self.adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_offset(0);
        }];
        
    }
    return self;
}

#pragma mark - 图片被点击
- (void)tapAction:(UITapGestureRecognizer *)sender {
    if (self.clickBlock) {
        self.clickBlock(sender.view.tag);
    }
}

- (void)setImageURLString:(NSString *)imageURLString {
    _imageURLString = imageURLString;
    [self.adImageView setYy_imageURL:[NSURL URLWithString:_imageURLString]];

}

#pragma mark - lazy
- (UIImageView *)adImageView {
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] init];
        [_adImageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_adImageView addGestureRecognizer:tap];
    }
    return _adImageView;
}

@end
