//
//  ConfirmOrderViewController.h
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@interface ConfirmOrderViewController : BaseViewController

/** 商品 id */
@property(nonatomic , copy)NSString *goodsID;
/** 商品规格 id */
@property(nonatomic , copy)NSString *optionID;
/** 商品数量 */
@property(nonatomic , copy)NSString *goodsNum;

@end
