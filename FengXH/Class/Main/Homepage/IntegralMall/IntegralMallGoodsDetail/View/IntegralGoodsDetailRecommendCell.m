//
//  IntegralGoodsDetailRecommendCell.m
//  FengXH
//
//  Created by sun on 2018/9/29.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralGoodsDetailRecommendCell.h"
#import "IntegralGoodsDetailResultModel.h"

@interface IntegralGoodsDetailRecommendCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** collectionView */
@property(nonatomic , strong)UICollectionView *recommendCollectionView;

@end

@implementation IntegralGoodsDetailRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.recommendCollectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.recommendCollectionView.frame = self.contentView.frame;
}

- (void)setRecommendGoodsArray:(NSArray *)recommendGoodsArray {
    _recommendGoodsArray = recommendGoodsArray;
    [self.recommendCollectionView reloadData];
}

#pragma mark - collectionView
- (UICollectionView *)recommendCollectionView {
    if (!_recommendCollectionView) {
        UICollectionViewFlowLayout *_customLayout = [[UICollectionViewFlowLayout alloc]init];//定义的布局对象
        _customLayout.minimumLineSpacing = 0;
        _customLayout.minimumInteritemSpacing = 0;
        _customLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _recommendCollectionView = [[UICollectionView alloc]initWithFrame:self.contentView.frame collectionViewLayout:_customLayout];
        _recommendCollectionView.backgroundColor = [UIColor whiteColor];
        _recommendCollectionView.delegate = self;
        _recommendCollectionView.dataSource = self;
        _recommendCollectionView.showsVerticalScrollIndicator = NO;
        _recommendCollectionView.showsHorizontalScrollIndicator = NO;
        _recommendCollectionView.alwaysBounceVertical = YES;
        [_recommendCollectionView registerClass:[IntegralGoodsDetailRecommendGoodsCell class] forCellWithReuseIdentifier:NSStringFromClass([IntegralGoodsDetailRecommendGoodsCell class])];
    }
    return _recommendCollectionView;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recommendGoodsArray.count;
}

#pragma mark - UICollectionViewDelegateFlowLayout 每个 item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width/3, collectionView.frame.size.height);
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IntegralGoodsDetailRecommendGoodsCell *goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([IntegralGoodsDetailRecommendGoodsCell class]) forIndexPath:indexPath];
    goodsCell.recommendGoodsModel = self.recommendGoodsArray[indexPath.item];
    return goodsCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    IntegralGoodsDetailResultGoodsRecommendModel *recommendModel = self.recommendGoodsArray[indexPath.item];
    if (self.delegate && [self.delegate respondsToSelector:@selector(IntegralGoodsDetailRecommendCell:didSelectRecommendGoodsWith:)]) {
        [self.delegate IntegralGoodsDetailRecommendCell:self didSelectRecommendGoodsWith:recommendModel];
    }
}


@end



@interface IntegralGoodsDetailRecommendGoodsCell ()

/** 商品图 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 商品名 */
@property(nonatomic , strong)UILabel *goodsNameLabel;
/** 价格 */
@property(nonatomic , strong)UILabel *priceLabel;

@end

@implementation IntegralGoodsDetailRecommendGoodsCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo(self.frame.size.width);
        }];
        
        [self.contentView addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(10);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-10);
        }];
        
    }
    return self;
}

- (void)setRecommendGoodsModel:(IntegralGoodsDetailResultGoodsRecommendModel *)recommendGoodsModel {
    _recommendGoodsModel = recommendGoodsModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_recommendGoodsModel.thumb]];
    [self.goodsNameLabel setText:_recommendGoodsModel.title];
    if ([_recommendGoodsModel.money floatValue] > 0) {
        NSString *creditString = [NSString stringWithFormat:@"%ld",(long)_recommendGoodsModel.credit];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分 + ¥%.2lf",creditString,[_recommendGoodsModel.money floatValue]]];
        [attributedString addAttributes:@{NSFontAttributeName:KFont(10)} range:NSMakeRange(creditString.length, 2)];
        NSRange range = [[NSString stringWithFormat:@"%@积分 + ¥%.2lf",creditString,[_recommendGoodsModel.money floatValue]] rangeOfString:@"¥"];
        [attributedString addAttributes:@{NSFontAttributeName:KFont(11)} range:range];
        [self.priceLabel setAttributedText:attributedString];
    } else {
        NSString *creditString = [NSString stringWithFormat:@"%ld",(long)_recommendGoodsModel.credit];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分",creditString]];
        [attributedString addAttributes:@{NSFontAttributeName:KFont(10)} range:NSMakeRange(creditString.length, 2)];
        [self.priceLabel setAttributedText:attributedString];
    }
}

#pragma mark - lazy
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor:KRedColor];
        [_priceLabel setFont:KFont(15)];
        [_priceLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _priceLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(12)];
        [_goodsNameLabel setNumberOfLines:2];
    }
    return _goodsNameLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
}

@end;
