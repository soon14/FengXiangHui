//
//  HomePageFoodieGoodsCell.h
//  FengXH
//
//  Created by sun on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//
//  吃货联盟商品

#import <UIKit/UIKit.h>
@class HomePageFoodieGoodsCell,HomepageDataCategoryGoodsDataModel,HomePageFoodieGoodsDetailCell,HomepageDataFirstCategoryGoodsModel,HomepageDataGuessYouLikeGoodsDataModel;

@protocol HomePageFoodieGoodsDelegate <NSObject>

/**
 点击了商品
 
 @param cell cell
 @param goodsDataModel 商品模型
 */
- (void)HomePageFoodieGoodsCell:(HomePageFoodieGoodsCell *)cell didSelectItemWith:(HomepageDataCategoryGoodsDataModel *)goodsDataModel;

/**
 点击了购物车item
 
 @param cell cell
 @param goodsDataModel 商品模型
 */
- (void)HomePageFoodieGoodsCell:(HomePageFoodieGoodsCell *)cell didSelectShoppingCartWith:(HomepageDataCategoryGoodsDataModel *)goodsDataModel;
@end

@interface HomePageFoodieGoodsCell : UICollectionViewCell

/** 吃货联盟商品代理 */
@property(nonatomic , weak)id <HomePageFoodieGoodsDelegate> delegate;
/** 吃货联盟商品数组模型 */
//@property (strong , nonatomic) HomepageDataFirstCategoryGoodsModel * foodieModel ;
/** 吃货联盟商品等等数组模型数组 */
@property(nonatomic , strong)NSArray * foodsArray ;

@end


@protocol HomePageFoodieGoodsDetailDelegate <NSObject>
@optional
- (void)HomePageFoodieGoodsDetailCell:(HomePageFoodieGoodsDetailCell *)cell didSelectShoppingCartButtonWith:(HomepageDataCategoryGoodsDataModel *)goodsDataModel;
- (void)HomePageFoodieGoodsDetailCell:(HomePageFoodieGoodsDetailCell *)cell didSelectShoppingCartButtonWithGuessLickModel:(HomepageDataGuessYouLikeGoodsDataModel *)guessLikeModel;
@end

@interface HomePageFoodieGoodsDetailCell : UICollectionViewCell
/** 其他版块模型 */
@property(nonatomic , strong)HomepageDataCategoryGoodsDataModel *goodsDataModel ;
/** 猜你喜欢模型 */
@property(nonatomic , strong)HomepageDataGuessYouLikeGoodsDataModel *guessLikeModel ;
/** 代理 */
@property(nonatomic , weak)id <HomePageFoodieGoodsDetailDelegate> delegate;
@end
