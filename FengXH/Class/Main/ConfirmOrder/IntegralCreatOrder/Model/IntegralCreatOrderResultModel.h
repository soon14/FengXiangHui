//
//  IntegralCreatOrderResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/22.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegralCreatOrderResultModel : NSObject

/** 是否含运费 */
@property(nonatomic , copy)NSString *contain;
/** 积分数 */
@property(nonatomic , copy)NSString *credit;
/** 运费 */
@property(nonatomic , copy)NSString *dispatch;
/** id */
@property(nonatomic , copy)NSString *orderID;
/** 需支付价格 */
@property(nonatomic , copy)NSString *money;
/** 所需积分与价格(加运费) */
@property(nonatomic , copy)NSString *price;
/** 商城名字 */
@property(nonatomic , copy)NSString *shopname;
/** 所需积分与价格(不加运费) */
@property(nonatomic , copy)NSString *subtotal;
/** 图 */
@property(nonatomic , copy)NSString *thumb;
/** 商品名 */
@property(nonatomic , copy)NSString *title;

@end
