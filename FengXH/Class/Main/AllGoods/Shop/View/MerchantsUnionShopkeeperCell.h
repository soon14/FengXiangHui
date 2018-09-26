//
//  MerchantsUnionShopkeeperCell.h
//  FengXH
//
//  Created by sun on 2018/9/25.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailResultShopdetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface MerchantsUnionShopkeeperCell : UICollectionViewCell

/** model */
@property(nonatomic , strong)GoodsDetailResultShopdetailModel *shopDetailModel;

@end

NS_ASSUME_NONNULL_END
