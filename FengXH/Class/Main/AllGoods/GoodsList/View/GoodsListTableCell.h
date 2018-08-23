//
//  GoodsListTableCell.h
//  FengXH
//
//  Created by sun on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsListCommodityModel,GoodsListTableCell;

@protocol GoodsListTableCellDelegate <NSObject>
/** 点击了购物车item */
- (void)GoodsListTableCell:(GoodsListTableCell *)cell didSelectShoppingCartWith:(GoodsListCommodityModel *)commodityModel;
@end

@interface GoodsListTableCell : UICollectionViewCell

/** 数据模型 */
@property(nonatomic , strong)GoodsListCommodityModel *goodsListCommodityModel;
/** 购物车点击代理 */
@property(nonatomic , weak)id <GoodsListTableCellDelegate> delegate;

@end
