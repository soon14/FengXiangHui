//
//  GoodsDetailQuelityCell.m
//  FengXH
//
//  Created by sun on 2018/9/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GoodsDetailQuelityCell.h"

@interface GoodsDetailQuelityCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** collectionView */
@property(nonatomic , strong)UICollectionView *collectionView;

@end

@implementation GoodsDetailQuelityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KUIColorFromHex(0xf7f7f7);
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.contentView.frame;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width / 3, 25);
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.qualityArray.count > 6) {
        return 6;
    } return self.qualityArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailQuelityItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GoodsDetailQuelityItemCell class]) forIndexPath:indexPath];
    cell.quality = self.qualityArray[indexPath.item];
    return cell;
}

#pragma mark 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = KUIColorFromHex(0xf7f7f7);
        [_collectionView registerClass:[GoodsDetailQuelityItemCell class] forCellWithReuseIdentifier:NSStringFromClass([GoodsDetailQuelityItemCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end



@interface GoodsDetailQuelityItemCell ()

/** label */
@property(nonatomic , strong)UILabel *qualityLabel;

@end

@implementation GoodsDetailQuelityItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [imageV setImage:[UIImage imageNamed:@"goodsDetailquality"]];
        [self.contentView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.height.mas_equalTo(10);
        }];
        
        [self.contentView addSubview:self.qualityLabel];
        [self.qualityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(imageV.mas_right).offset(5);
            make.right.mas_offset(-5);
        }];
        
    }
    return self;
}

- (void)setQuality:(NSString *)quality {
    _quality = quality;
    [self.qualityLabel setText:_quality];
}

#pragma mark - lazy
- (UILabel *)qualityLabel {
    if (!_qualityLabel) {
        _qualityLabel = [[UILabel alloc] init];
        [_qualityLabel setTextColor:KUIColorFromHex(0x999999)];
        [_qualityLabel setFont:KFont(11)];
    }
    return _qualityLabel;
}

@end










