//
//  UnionMerchantGoodsCell.m
//  FengXH
//
//  Created by sun on 2018/10/12.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "UnionMerchantContentCell.h"
#import "UnionMerchantResultModel.h"

@interface UnionMerchantContentCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** collection */
@property(nonatomic , strong)UICollectionView *goodsCollectionView;

@end

@implementation UnionMerchantContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.goodsCollectionView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.goodsCollectionView.frame = self.contentView.frame;
}

- (void)setGoodsArray:(NSArray *)goodsArray {
    _goodsArray = goodsArray;
    [self.goodsCollectionView reloadData];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((collectionView.frame.size.width-20) / 3.0, collectionView.frame.size.height);
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
    return self.goodsArray.count;;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UnionMerchantGoodsCell * goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UnionMerchantGoodsCell class]) forIndexPath:indexPath];
    goodsCell.goodsModel = self.goodsArray[indexPath.item];
    return goodsCell;
}

#pragma mark - <HomePageFoodieGoodsDetailDelegate>
//- (void)HomePageFoodieGoodsDetailCell:(HomePageFoodieGoodsDetailCell *)cell didSelectShoppingCartButtonWith:(HomepageDataCategoryGoodsDataModel *)goodsDataModel {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageFoodieGoodsCell:didSelectShoppingCartWith:)]) {
//        [self.delegate HomePageFoodieGoodsCell:self didSelectShoppingCartWith:goodsDataModel];
//    }
//}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(UnionMerchantContentCell:didSelectItemWith:)]) {
        [self.delegate UnionMerchantContentCell:self didSelectItemWith:self.goodsArray[indexPath.item]];
    }
}

#pragma mark 懒加载
- (UICollectionView *)goodsCollectionView {
    if (!_goodsCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _goodsCollectionView = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        _goodsCollectionView.backgroundColor = [UIColor whiteColor];
        [_goodsCollectionView registerClass:[UnionMerchantGoodsCell class] forCellWithReuseIdentifier:NSStringFromClass([UnionMerchantGoodsCell class])];
        _goodsCollectionView.dataSource = self;
        _goodsCollectionView.delegate = self;
        _goodsCollectionView.showsVerticalScrollIndicator = NO;
        _goodsCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _goodsCollectionView;
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




@interface UnionMerchantGoodsCell ()

/** goodsImageV */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** title */
@property(nonatomic , strong)UILabel *goodsTitleLabel;
/** price */
@property(nonatomic , strong)UILabel *priceLabel;

@end



@implementation UnionMerchantGoodsCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo(self.contentView.frame.size.width);
        }];
        
        [self.contentView addSubview:self.goodsTitleLabel];
        [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(5);
            make.left.mas_equalTo(_goodsImageView.mas_left);
            make.right.mas_equalTo(_goodsImageView.mas_right);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        [label setBackgroundColor:KRedColor];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:KFont(13)];
        [label setText:@"购买"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label.layer setMasksToBounds:YES];
        [label.layer setCornerRadius:2];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_goodsTitleLabel.mas_bottom).offset(8);
            make.right.mas_equalTo(_goodsImageView.mas_right);
            make.width.mas_equalTo(36);
            make.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsImageView.mas_left);
            make.centerY.mas_equalTo(label.mas_centerY);
            make.right.mas_equalTo(label.mas_left).offset(-3);
        }];
        
    }
    return self;
}

- (void)setGoodsModel:(UnionMerchantResultItemsItemsModel *)goodsModel {
    _goodsModel = goodsModel;
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_goodsModel.thumb]];
    [self.goodsTitleLabel setText:_goodsModel.title];
    [self.priceLabel setText:[NSString stringWithFormat:@"¥%.2lf",[_goodsModel.price floatValue]]];
    
}

#pragma mark - lazy
- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
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

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor:KRedColor];
        [_priceLabel setFont:KFont(14)];
        [_priceLabel setAdjustsFontSizeToFitWidth:YES];
    }
    return _priceLabel;
}

@end


