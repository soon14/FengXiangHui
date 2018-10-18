//
//  MerchantsUnionViewController.h
//  FengXH
//
//  Created by sun on 2018/9/25.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "BaseViewController.h"
@class GoodsDetailResultModel,UnionMerchantResultItemsItemsModel;

NS_ASSUME_NONNULL_BEGIN

@interface MerchantsUnionViewController : BaseViewController

/** 商品详情页传进来的 Model */
@property(nonatomic , strong)GoodsDetailResultModel *goodsDetailResultModel;
/** 联盟商户传进来的 Model */
@property(nonatomic , strong)UnionMerchantResultItemsItemsModel *unionMerchantModel;

@end

NS_ASSUME_NONNULL_END
