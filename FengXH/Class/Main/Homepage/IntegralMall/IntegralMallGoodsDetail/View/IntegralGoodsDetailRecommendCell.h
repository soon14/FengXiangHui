//
//  IntegralGoodsDetailRecommendCell.h
//  FengXH
//
//  Created by sun on 2018/9/29.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class IntegralGoodsDetailRecommendCell,IntegralGoodsDetailResultGoodsRecommendModel;
@protocol IntegralGoodsDetailRecommendCellDelegate <NSObject>

- (void)IntegralGoodsDetailRecommendCell:(IntegralGoodsDetailRecommendCell *)cell didSelectRecommendGoodsWith:(IntegralGoodsDetailResultGoodsRecommendModel *)goodsDataModel;

@end

@interface IntegralGoodsDetailRecommendCell : UITableViewCell

/** 推荐商品 */
@property(nonatomic , strong)NSArray *recommendGoodsArray;
/** 推荐商品点击代理 */
@property(nonatomic , weak)id <IntegralGoodsDetailRecommendCellDelegate> delegate;

@end


@interface IntegralGoodsDetailRecommendGoodsCell : UICollectionViewCell

/** model */
@property(nonatomic , strong)IntegralGoodsDetailResultGoodsRecommendModel *recommendGoodsModel;

@end

NS_ASSUME_NONNULL_END
