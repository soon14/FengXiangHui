//
//  GoodsDetailCartPopupView.h
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HBPopupView.h"

typedef NS_ENUM(NSInteger, GoodsDetailPopupType) {
    GoodsDetailAddToCartType = 0,   //添加至购物车
    GoodsDetailBuyNowType       //立即购买
};

@interface GoodsDetailPopupView : HBPopupView

/** 弹出类型 */
@property(nonatomic , assign)GoodsDetailPopupType popupType;

@end
