//
//  GoodsListCollectionCell.h
//  FengXH
//
//  Created by sun on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsListCommodityModel,GoodsListCollectionCell;

@protocol GoodsListCollectionCellDelegate <NSObject>
/** 点击了购物车item */
- (void)GoodsListCollectionCell:(GoodsListCollectionCell *)cell didSelectShoppingCartWith:(GoodsListCommodityModel *)commodityModel;
@end

@interface GoodsListCollectionCell : UICollectionViewCell

/** 数据模型 */
@property(nonatomic , strong)GoodsListCommodityModel *goodsListCommodityModel;
/** 购物车点击代理 */
@property(nonatomic , weak)id <GoodsListCollectionCellDelegate> delegate;

@end
