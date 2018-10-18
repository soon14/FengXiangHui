//
//  HomePageFunctionCell.m
//  FengXH
//
//  Created by sun on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomePageFunctionCell.h"
#import "HomepageResultModel.h"

@interface HomePageFunctionCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 功能functionCell */
@property(nonatomic , strong)UICollectionView *functionCollection ;
@end

@implementation HomePageFunctionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.functionCollection];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.functionCollection.frame = self.contentView.frame;
}

- (void)setMenuDataArray:(NSArray<HomepageResultPictureModel *> *)menuDataArray {
    _menuDataArray = menuDataArray;
    [self.functionCollection reloadData];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width / 5.0, 100.0);
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.menuDataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePageFunctionItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePageFunctionItemCell class]) forIndexPath:indexPath];
    cell.functionItemModel = self.menuDataArray[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomepageResultPictureModel * menuDateModel = self.menuDataArray[indexPath.item];
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePageFunctionCell:didSelectFunctiomItemWith:)]) {
        [self.delegate HomePageFunctionCell:self didSelectFunctiomItemWith:menuDateModel];
    }
}

#pragma mark 懒加载
- (UICollectionView *)functionCollection {
    if (!_functionCollection) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _functionCollection = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        _functionCollection.backgroundColor = [UIColor whiteColor];
        [_functionCollection registerClass:[HomePageFunctionItemCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePageFunctionItemCell class])];
        _functionCollection.delegate = self;
        _functionCollection.dataSource = self;
    }
    return _functionCollection;
}

@end


@interface HomePageFunctionItemCell ()
/** imageView */
@property(nonatomic , strong)UIImageView *itemImageView;
/** title */
@property(nonatomic , strong)UILabel *itemTitleLabel;
@end

@implementation HomePageFunctionItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.itemImageView];
        [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.height.mas_equalTo(45);
        }];
        
        [self.contentView addSubview:self.itemTitleLabel];
        [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.itemImageView.mas_bottom).offset(15);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
    }
    return self;
}

- (void)setFunctionItemModel:(HomepageResultPictureModel *)functionItemModel {
    _functionItemModel = functionItemModel;
    [self.itemImageView setYy_imageURL:[NSURL URLWithString:_functionItemModel.imgurl]];
    [self.itemTitleLabel setText:_functionItemModel.text];
}

#pragma mark - lazy
- (UILabel *)itemTitleLabel {
    if (!_itemTitleLabel) {
        _itemTitleLabel = [[UILabel alloc] init];
        [_itemTitleLabel setFont:KFont(13)];
        [_itemTitleLabel setTextColor:KUIColorFromHex(0x666666)];
        [_itemTitleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _itemTitleLabel;
}

- (UIImageView *)itemImageView {
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] init];
    }
    return _itemImageView;
}

@end
