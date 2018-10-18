//
//  HomePageCategoryCell.m
//  FengXH
//
//  Created by sun on 2018/10/12.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "HomePageCategoryCell.h"
#import "HomepageResultModel.h"

@interface HomePageCategoryCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HomePageCategoryGoodsCellDelegate>

//分类图片
@property(nonatomic , strong)UIImageView * categoryImageView;
/** celloction */
@property(nonatomic , strong)UICollectionView *goodsCollectionView;

@end

@implementation HomePageCategoryCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.categoryImageView];
        [self.categoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(100*KScreenRatio);
        }];
        
        [self.contentView addSubview:self.goodsCollectionView];
        [self.goodsCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_categoryImageView.mas_bottom);
            make.left.bottom.right.mas_offset(0);
        }];
        
    }
    return self;
}

- (void)setResultGoodsModel:(HomepageResultGoodsModel *)resultGoodsModel {
    _resultGoodsModel = resultGoodsModel;
    if ([_resultGoodsModel.picture count] > 0) {
        HomepageResultPictureModel *pictureModel = [_resultGoodsModel.picture firstObject];
        [self.categoryImageView setYy_imageURL:[NSURL URLWithString:pictureModel.imgurl]];
    }
    [self.goodsCollectionView reloadData];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(125*KScreenRatio, collectionView.frame.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

#pragma mark - 分区内每个上下 item 的高度间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.resultGoodsModel.list.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageCategoryGoodsCell * goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageCategoryGoodsCell class]) forIndexPath:indexPath];
    goodsCell.delegate = self;
    goodsCell.categoryGoodsModel = self.resultGoodsModel.list[indexPath.item];
    return goodsCell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomepageResultCommodityModel * goodsModel = self.resultGoodsModel.list[indexPath.item];
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageCategoryCell:didSelectGoodsItemWith:)]) {
        [self.delegate HomePageCategoryCell:self didSelectGoodsItemWith:goodsModel];
    }
}

#pragma mark - 点击购物车按钮
- (void)HomePageCategoryGoodsCell:(HomePageCategoryGoodsCell *)cell didSelectShoppingCartWith:(HomepageResultCommodityModel *)goodsDataModel {
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageCategoryCell:didSelectGoodsItemWith:)]) {
        [self.delegate HomePageCategoryCell:self didSelectGoodsItemWith:goodsDataModel];
    }
}


#pragma mark - lazy
- (UICollectionView *)goodsCollectionView{
    if (!_goodsCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _goodsCollectionView = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        [_goodsCollectionView registerClass:[HomePageCategoryGoodsCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageCategoryGoodsCell class])];
        _goodsCollectionView.showsHorizontalScrollIndicator = NO;
        _goodsCollectionView.backgroundColor = [UIColor whiteColor];
        _goodsCollectionView.delegate = self;
        _goodsCollectionView.dataSource = self;
    }
    return _goodsCollectionView;
}

- (UIImageView *)categoryImageView {
    if (!_categoryImageView) {
        _categoryImageView = [[UIImageView alloc] init];
        [_categoryImageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _categoryImageView;
}

@end




@interface HomePageCategoryGoodsCell ()

/** 商品图片 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 商品名称 */
@property(nonatomic , strong)UILabel *goodsTitleLabel;
/** 现价 */
@property(nonatomic , strong)UILabel *nowPriceLabel;
/** 原价 */
@property(nonatomic , strong)UILabel *originPriceLabel;
/** 购物车按钮 */
@property(nonatomic , strong)UIButton *cartButton;

@end

@implementation HomePageCategoryGoodsCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(self.frame.size.width);
        }];
        
        [self addSubview:self.goodsTitleLabel];
        [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goodsImageView.mas_bottom).offset(5);
            make.left.mas_offset(3);
            make.right.mas_offset(-3);
        }];
        
        [self addSubview:self.originPriceLabel];
        [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goodsTitleLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(_goodsTitleLabel.mas_left);
        }];
        
        [self addSubview:self.nowPriceLabel];
        [self.nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.originPriceLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(_goodsTitleLabel.mas_left);
        }];
        
        [self addSubview:self.cartButton];
        [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-7);
            make.bottom.mas_offset(-5);
            make.width.height.mas_equalTo(36);
        }];
        
    }
    return self;
}

- (void)setCategoryGoodsModel:(HomepageResultCommodityModel *)categoryGoodsModel {
    _categoryGoodsModel = categoryGoodsModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_categoryGoodsModel.thumb]];
    [self.goodsTitleLabel setText:_categoryGoodsModel.title];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价¥%@",_categoryGoodsModel.productprice]];
    [attString addAttributes:@{NSFontAttributeName:KFont(13), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSStrikethroughColorAttributeName:[UIColor lightGrayColor], NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(2, _categoryGoodsModel.productprice.length+1)];
    [self.originPriceLabel setAttributedText:attString];
    [self.nowPriceLabel setText:[NSString stringWithFormat:@"¥%@",_categoryGoodsModel.marketprice]];
}


#pragma mark - 购物车方法
- (void)cartButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageCategoryGoodsCell:didSelectShoppingCartWith:)]) {
        [self.delegate HomePageCategoryGoodsCell:self didSelectShoppingCartWith:self.categoryGoodsModel];
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
        
    }
    return _nowPriceLabel;
}

- (UILabel *)originPriceLabel {
    if (!_originPriceLabel) {
        _originPriceLabel = [[UILabel alloc] init];
        [_originPriceLabel setTextColor:KUIColorFromHex(0x999999)];
        [_originPriceLabel setFont:KFont(13)];
        [_originPriceLabel setAdjustsFontSizeToFitWidth:YES];
        
    }
    return _originPriceLabel;
}

- (UILabel *)goodsTitleLabel {
    if (!_goodsTitleLabel) {
        _goodsTitleLabel = [[UILabel alloc] init];
        [_goodsTitleLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsTitleLabel setFont:KFont(14)];
        [_goodsTitleLabel setNumberOfLines:2];
    }
    return _goodsTitleLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        [_goodsImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _goodsImageView;
}

@end
