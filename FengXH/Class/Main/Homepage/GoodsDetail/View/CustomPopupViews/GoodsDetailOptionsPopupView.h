//
//  GoodsDetailCartPopupView.h
//  FengXH
//
//  Created by sun on 2018/9/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HBPopupView.h"
@class GoodsDetailResultModel;
//typedef NS_ENUM(NSInteger, GoodsDetailPopupType) {
//    GoodsDetailAddToCartType = 0,   //添加至购物车
//    GoodsDetailBuyNowType       //立即购买
//};

@interface GoodsDetailOptionsPopupView : HBPopupView

/** model */
@property(nonatomic , strong)GoodsDetailResultModel *goodsDetailResultModel;
///** 弹出类型 */
//@property(nonatomic , assign)GoodsDetailPopupType popupType;

@end
