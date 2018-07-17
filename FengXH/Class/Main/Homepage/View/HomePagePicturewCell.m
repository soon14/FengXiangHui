//
//  HomePagePicturewCell.m
//  FengXH
//
//  Created by 孙湖滨 on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomePagePicturewCell.h"
#import "HomepageDataModel.h"

@interface HomePagePicturewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** CollectionView */
@property(nonatomic , strong)UICollectionView * pictureCollection ;
@end

@implementation HomePagePicturewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    // 应为cell复用问题，不同板块的cell高度不一样，但是内部的collectionview是按照板块高度约束的，从147高度的板块到45（猜你喜欢）高度的板块过度的时候会有一个FlowLayout警告说约束出错，所以需要在复用的时候重新约束布局。
    self.pictureCollection.frame = self.contentView.frame;
    [self.pictureCollection reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.pictureCollection];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.pictureCollection.frame = self.contentView.frame;
}

- (void)setPictureArray:(NSArray *)pictureArray {
    _pictureArray = pictureArray;
    self.pictureCollection.frame = self.contentView.frame;
    [self.pictureCollection reloadData];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width / self.pictureArray.count, collectionView.frame.size.height);
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pictureArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePagePicturewImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomePagePicturewImageCell class]) forIndexPath:indexPath];
    cell.pictureModel = self.pictureArray[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomepageDataMenuDataModel * menuDateModel = self.pictureArray[indexPath.item];
    if (self.delegate && [self.delegate respondsToSelector:@selector(HomePagePicturewCell:didSelectPicturerwItemWith:)]) {
        [self.delegate HomePagePicturewCell:self didSelectPicturerwItemWith:menuDateModel];
    }
}

#pragma mark 懒加载
- (UICollectionView *)pictureCollection{
    if (!_pictureCollection) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        
        _pictureCollection = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        [_pictureCollection registerClass:[HomePagePicturewImageCell class] forCellWithReuseIdentifier:NSStringFromClass([HomePagePicturewImageCell class])];
        _pictureCollection.backgroundColor = [UIColor whiteColor];
        _pictureCollection.delegate = self;
        _pictureCollection.dataSource = self;
    }
    return _pictureCollection;
}
@end


@interface HomePagePicturewImageCell ()
@property(nonatomic , strong)UIImageView * pictureImageView;
@end

@implementation HomePagePicturewImageCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.pictureImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.pictureImageView.frame = self.contentView.frame;
}

- (void)setPictureModel:(HomepageDataMenuDataModel *)pictureModel {
    _pictureModel = pictureModel;
    [self.pictureImageView setYy_imageURL:[NSURL URLWithString:_pictureModel.imgurl]];
}

#pragma mark 懒加载
- (UIImageView *)pictureImageView {
    if (!_pictureImageView) {
        _pictureImageView = [[UIImageView alloc] init];
        [_pictureImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _pictureImageView;
}
@end




