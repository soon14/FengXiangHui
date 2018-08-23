//
//  HomePageSecondKillGoodsCell.m
//  FengXH
//
//  Created by sun on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomePageSecondKillGoodsCell.h"
#import "HomepageDataModel.h"

@interface HomePageSecondKillGoodsCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** CollectionView */
@property(nonatomic , strong)UICollectionView * secondKillCollection ;

@end

@implementation HomePageSecondKillGoodsCell

- (void)prepareForReuse {
    [super prepareForReuse];
    // 应为cell复用问题，不同板块的cell高度不一样，但是内部的collectionview是按照板块高度约束的，从147高度的板块到45（猜你喜欢）高度的板块过度的时候会有一个FlowLayout警告说约束出错，所以需要在复用的时候重新约束布局。
    self.secondKillCollection.frame = self.contentView.frame;
    [self.secondKillCollection reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.secondKillCollection];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.secondKillCollection.frame = self.contentView.frame;
}

- (void)setGoodsArray:(NSArray *)goodsArray {
    _goodsArray = goodsArray;
    self.secondKillCollection.frame = self.contentView.frame;
    [self.secondKillCollection reloadData];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(85, collectionView.frame.size.height);
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageSecondKillGoodsDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageSecondKillGoodsDetailCell class]) forIndexPath:indexPath];
    cell.goodsModel = self.goodsArray[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomepageDataSecondKillGoodsModel * goodsModel = self.goodsArray[indexPath.item];
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageSecondKillGoodsCell:didSelectGoodsItemWith:)]) {
        [self.delegate HomePageSecondKillGoodsCell:self didSelectGoodsItemWith:goodsModel];
    }
}

#pragma mark 懒加载
- (UICollectionView *)secondKillCollection{
    if (!_secondKillCollection) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        
        _secondKillCollection = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        [_secondKillCollection registerClass:[HomePageSecondKillGoodsDetailCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageSecondKillGoodsDetailCell class])];
        _secondKillCollection.showsHorizontalScrollIndicator = NO;
        _secondKillCollection.backgroundColor = [UIColor whiteColor];
        _secondKillCollection.delegate = self;
        _secondKillCollection.dataSource = self;
    }
    return _secondKillCollection;
}
@end



@interface HomePageSecondKillGoodsDetailCell ()

/** 商品图片 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 秒杀价 */
@property(nonatomic , strong)UILabel *nowPriceLabel;
/** 原价 */
@property(nonatomic , strong)UILabel *originPriceLabel;

@end

@implementation HomePageSecondKillGoodsDetailCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo(80);
        }];
        
        [self addSubview:self.nowPriceLabel];
        [self.nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goodsImageView.mas_bottom).offset(12);
            make.left.right.mas_offset(0);
        }];
        
        [self addSubview:self.originPriceLabel];
        [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nowPriceLabel.mas_bottom).offset(0);
            make.left.right.mas_offset(0);
        }];
        
    }
    return self;
}

- (void)setGoodsModel:(HomepageDataSecondKillGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:goodsModel.thumb]];
    [self.nowPriceLabel setText:[NSString stringWithFormat:@"¥%@",goodsModel.price]];
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",goodsModel.marketprice] attributes:@{NSFontAttributeName:KFont(11), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSStrikethroughColorAttributeName:[UIColor lightGrayColor], NSBaselineOffsetAttributeName:@(0)}];
    [self.originPriceLabel setAttributedText:attString];
}

#pragma mark - lazy
- (UILabel *)originPriceLabel {
    if (!_originPriceLabel) {
        _originPriceLabel = [[UILabel alloc] init];
        [_originPriceLabel setTextColor:KUIColorFromHex(0x999999)];
        [_originPriceLabel setFont:KFont(11)];
        [_originPriceLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _originPriceLabel;
}

- (UILabel *)nowPriceLabel {
    if (!_nowPriceLabel) {
        _nowPriceLabel = [[UILabel alloc] init];
        [_nowPriceLabel setTextColor:KRedColor];
        [_nowPriceLabel setFont:KFont(14)];
        [_nowPriceLabel setTextAlignment:NSTextAlignmentCenter];
        [_nowPriceLabel setText:@"¥329"];
    }
    return _nowPriceLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        [_goodsImageView setBackgroundColor:KTableBackgroundColor];
    }
    return _goodsImageView;
}

@end
