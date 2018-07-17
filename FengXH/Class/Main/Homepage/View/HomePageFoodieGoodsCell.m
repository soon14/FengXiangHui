//
//  HomePageFoodieGoodsCell.m
//  FengXH
//
//  Created by 孙湖滨 on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomePageFoodieGoodsCell.h"
#import "HomepageDataModel.h"

@interface HomePageFoodieGoodsCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HomePageFoodieGoodsDetailDelegate>
/** 吃货联盟商品图片 */
@property (strong , nonatomic) UICollectionView * foodieCollection ;
@end

@implementation HomePageFoodieGoodsCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.foodieCollection];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.foodieCollection.frame = self.contentView.frame;
}

- (void)setFoodsArray:(NSArray *)foodsArray {
    _foodsArray = foodsArray;
    [self.foodieCollection reloadData];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width / 3.0, collectionView.frame.size.height);
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.foodsArray.count;;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageFoodieGoodsDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageFoodieGoodsDetailCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    cell.goodsDataModel = self.foodsArray[indexPath.item];
    return cell;
}

#pragma mark - <HomePageFoodieGoodsDetailDelegate>
- (void)HomePageFoodieGoodsDetailCell:(HomePageFoodieGoodsDetailCell *)cell didSelectShoppingCartButtonWith:(HomepageDataCategoryGoodsDataModel *)goodsDataModel {
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageFoodieGoodsCell:didSelectShoppingCartWith:)]) {
        [self.delegate HomePageFoodieGoodsCell:self didSelectShoppingCartWith:goodsDataModel];
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageFoodieGoodsCell:didSelectItemWith:)]) {
        [self.delegate HomePageFoodieGoodsCell:self didSelectItemWith:self.foodsArray[indexPath.item]];
    }
}

#pragma mark 懒加载
- (UICollectionView *)foodieCollection {
    if (!_foodieCollection) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _foodieCollection = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        _foodieCollection.backgroundColor = [UIColor whiteColor];
        [_foodieCollection registerClass:[HomePageFoodieGoodsDetailCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageFoodieGoodsDetailCell class])];
        _foodieCollection.dataSource = self;
        _foodieCollection.delegate = self;
        _foodieCollection.showsVerticalScrollIndicator = NO;
        _foodieCollection.showsHorizontalScrollIndicator = NO;
    }
    return _foodieCollection;
}

@end


@interface HomePageFoodieGoodsDetailCell ()
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

@implementation HomePageFoodieGoodsDetailCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(136*KScreenRatio);
        }];
        
        [self addSubview:self.goodsTitleLabel];
        [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goodsImageView.mas_bottom).offset(5);
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
        }];
        
        [self addSubview:self.originPriceLabel];
        [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goodsTitleLabel.mas_bottom).offset(5);
            make.left.mas_offset(10);
        }];
        
        [self addSubview:self.nowPriceLabel];
        [self.nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.originPriceLabel.mas_bottom).offset(5);
            make.left.mas_offset(10);
        }];
        
        [self addSubview:self.cartButton];
        [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-5);
            make.width.height.mas_equalTo(36);
        }];
    }
    return self;
}

- (void)setGoodsDataModel:(HomepageDataCategoryGoodsDataModel *)goodsDataModel {
    _goodsDataModel = goodsDataModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_goodsDataModel.thumb]];
    [self.goodsTitleLabel setText:_goodsDataModel.title];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价¥%@",_goodsDataModel.productprice]];
    [attString addAttributes:@{NSFontAttributeName:KFont(13), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSStrikethroughColorAttributeName:[UIColor lightGrayColor], NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(2, _goodsDataModel.productprice.length+1)];
    [self.originPriceLabel setAttributedText:attString];
    if (_goodsDataModel.marketprice.length) {
        [self.nowPriceLabel setText:[NSString stringWithFormat:@"¥%@",_goodsDataModel.marketprice]];
    }
}

- (void)setGuessLikeModel:(HomepageDataGuessYouLikeGoodsDataModel *)guessLikeModel {
    _guessLikeModel = guessLikeModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_guessLikeModel.thumb]];
    [self.goodsTitleLabel setText:_guessLikeModel.title];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价¥%@",_guessLikeModel.productprice]];
    [attString addAttributes:@{NSFontAttributeName:KFont(13), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSStrikethroughColorAttributeName:[UIColor lightGrayColor], NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(2, _guessLikeModel.productprice.length+1)];
    [self.originPriceLabel setAttributedText:attString];
    [self.nowPriceLabel setText:[NSString stringWithFormat:@"¥%@",_guessLikeModel.marketprice]];
}

#pragma mark - 购物车方法
- (void)cartButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageFoodieGoodsDetailCell:didSelectShoppingCartButtonWith:)]) {
        [self.delegate HomePageFoodieGoodsDetailCell:self didSelectShoppingCartButtonWith:self.goodsDataModel];
    } else if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageFoodieGoodsDetailCell:didSelectShoppingCartButtonWithGuessLickModel:)]) {
        [self.delegate HomePageFoodieGoodsDetailCell:self didSelectShoppingCartButtonWithGuessLickModel:self.guessLikeModel];
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
    }
    return _goodsImageView;
}


@end
