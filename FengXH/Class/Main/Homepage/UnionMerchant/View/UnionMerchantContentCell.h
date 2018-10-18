//
//  UnionMerchantGoodsCell.h
//  FengXH
//
//  Created by sun on 2018/10/12.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class UnionMerchantContentCell,UnionMerchantResultItemsItemsModel;
@protocol UnionMerchantContentCellDelegate <NSObject>

/** 点击了商品 */
- (void)UnionMerchantContentCell:(UnionMerchantContentCell *)cell didSelectItemWith:(UnionMerchantResultItemsItemsModel *)goodsDataModel;

@end

@interface UnionMerchantContentCell : UITableViewCell

/** goodsArray */
@property(nonatomic , strong)NSArray *goodsArray;
/** 代理 */
@property(nonatomic , weak)id <UnionMerchantContentCellDelegate> delegate;

@end

@interface UnionMerchantGoodsCell : UICollectionViewCell

/** model */
@property(nonatomic , strong)UnionMerchantResultItemsItemsModel *goodsModel;

@end

NS_ASSUME_NONNULL_END
