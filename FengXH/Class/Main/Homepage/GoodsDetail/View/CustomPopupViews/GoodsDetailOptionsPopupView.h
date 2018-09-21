//
//  GoodsDetailCartPopupView.h
//  FengXH
//
//  Created by sun on 2018/9/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HBPopupView.h"
@class GoodsDetailResultModel,GoodsDetailResultOptionsModel;

typedef void (^GoodsDetailOptionsPopupViewBlock)(GoodsDetailResultOptionsModel *optionsModel, NSString *IDNumberString, NSString *goodsNum);

@interface GoodsDetailOptionsPopupView : HBPopupView

/** model */
@property(nonatomic , strong)GoodsDetailResultModel *goodsDetailResultModel;
/** block */
@property(nonatomic , strong)GoodsDetailOptionsPopupViewBlock optionsSelectedBlock;

@end
