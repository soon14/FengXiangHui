//
//  RightCollectionViewCell.m
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "AllGoodsRightCollectionViewCell.h"
#import "AllCategoryDataModel.h"

@interface AllGoodsRightCollectionViewCell ()

@property(nonatomic , strong)UIImageView *goodsImageView;
@property(nonatomic , strong)UILabel *goodsClassifyLabel;

@end


@implementation AllGoodsRightCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(77);
        }];
        
        
        [self addSubview:self.goodsClassifyLabel];
        [self.goodsClassifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(40);
        }];
        
    }
    return self;
}


- (void)setCategoryChildrenModel:(AllCategoryDataChildrenModel *)categoryChildrenModel {
    _categoryChildrenModel = categoryChildrenModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_categoryChildrenModel.thumb]];
    [self.goodsClassifyLabel setText:_categoryChildrenModel.name];
}

- (UILabel *)goodsClassifyLabel {
    if (!_goodsClassifyLabel) {
        _goodsClassifyLabel = [[UILabel alloc]init];
        [_goodsClassifyLabel setTextColor:KUIColorFromHex(0x666666)];
        [_goodsClassifyLabel setTextAlignment:NSTextAlignmentCenter];
        [_goodsClassifyLabel setFont:KFont(13)];
//        [_goodsClassifyLabel setText:@"粉底"];
    }
    return _goodsClassifyLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc]init];
//        [_goodsImageView setBackgroundColor:KTableBackgroundColor];
    }
    return _goodsImageView;
}


@end
