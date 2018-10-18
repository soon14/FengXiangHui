//
//  HomePageCategoryCell.h
//  FengXH
//
//  Created by sun on 2018/10/12.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HomepageResultGoodsModel,HomepageResultCommodityModel,HomePageCategoryCell;

@protocol HomePageCategoryCellDelegate <NSObject>

/** 点击了商品 */
- (void)HomePageCategoryCell:(HomePageCategoryCell *)cell didSelectGoodsItemWith:(HomepageResultCommodityModel *)goodsDataModel;

@end

@interface HomePageCategoryCell : UICollectionViewCell

/** model */
@property(nonatomic , strong)HomepageResultGoodsModel *resultGoodsModel;
/** delegate */
@property(nonatomic , weak)id <HomePageCategoryCellDelegate> delegate;

@end




@class HomePageCategoryGoodsCell;
@protocol HomePageCategoryGoodsCellDelegate <NSObject>

/** 点击了购物车item */
- (void)HomePageCategoryGoodsCell:(HomePageCategoryGoodsCell *)cell didSelectShoppingCartWith:(HomepageResultCommodityModel *)goodsDataModel;
@end

@interface HomePageCategoryGoodsCell : UICollectionViewCell

/** model */
@property(nonatomic , strong)HomepageResultCommodityModel *categoryGoodsModel;
/** delegate */
@property(nonatomic , weak)id <HomePageCategoryGoodsCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
