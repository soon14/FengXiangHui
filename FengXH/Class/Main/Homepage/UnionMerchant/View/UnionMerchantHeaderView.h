//
//  UnionMerchantHeaderView.h
//  FengXH
//
//  Created by sun on 2018/10/12.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class UnionMerchantHeaderView,UnionMerchantResultItemsItemsModel;
@protocol UnionMerchantHeaderViewDelegate <NSObject>

/** 点击了商铺 */
- (void)UnionMerchantHeaderView:(UnionMerchantHeaderView *)cell didSelectItemWith:(UnionMerchantResultItemsItemsModel *)merchantModel;

@end

@interface UnionMerchantHeaderView : UITableViewHeaderFooterView

/** merchantArray */
@property(nonatomic , strong)NSArray *merchantArray;
/** 代理 */
@property(nonatomic , weak)id <UnionMerchantHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
