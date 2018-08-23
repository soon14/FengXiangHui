//
//  MyOrderCell.h
//  FengXH
//
//  Created by sun on 2018/7/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyOrderResultListGoodsModel;

@interface OrderDefaultCell : UITableViewCell

/** 订单模型 */
@property(nonatomic , strong)MyOrderResultListGoodsModel *orderGoodsModel;

@end
