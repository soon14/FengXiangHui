//
//  IntegralRecordDetailResultModel.h
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IntegralRecordDetailResultExpressModel,IntegralRecordDetailResultAddressModel,IntegralRecordDetailResultGoodsModel;

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRecordDetailResultModel : NSObject

/** reward */
@property(nonatomic , copy)NSString *reward;
/** 状态 */
@property(nonatomic , copy)NSString *statust;
/** 运费 */
@property(nonatomic , copy)NSString *dispatch;
/** 订单号 */
@property(nonatomic , copy)NSString *logno;
/** 创建时间 */
@property(nonatomic , copy)NSString *createtime;
/** 支付时间 */
@property(nonatomic , copy)NSString *paytime;
/** 快递 */
@property(nonatomic , strong)IntegralRecordDetailResultExpressModel *express;
/** 收货地址 */
@property(nonatomic , strong)IntegralRecordDetailResultAddressModel *address;
/** 商品信息 */
@property(nonatomic , strong)IntegralRecordDetailResultGoodsModel *goods;

@end


@interface IntegralRecordDetailResultExpressModel : NSObject

/** expresscom */
@property(nonatomic , copy)NSString *expresscom;
/** expresssn */
@property(nonatomic , copy)NSString *expresssn;

@end


@interface IntegralRecordDetailResultAddressModel : NSObject

/** id */
@property(nonatomic , copy)NSString *addressID;
/** 收货人 */
@property(nonatomic , copy)NSString *realname;
/** 电话 */
@property(nonatomic , copy)NSString *mobile;
/** 地址 */
@property(nonatomic , copy)NSString *address;

@end


@interface IntegralRecordDetailResultGoodsModel : NSObject

/** 商品 id */
@property(nonatomic , copy)NSString *goodsID;
/** 消耗积分 */
@property(nonatomic , copy)NSString *credit;
/** 消耗金额 */
@property(nonatomic , copy)NSString *money;
/** 商品图片 */
@property(nonatomic , copy)NSString *thumb;
/** 商品名 */
@property(nonatomic , copy)NSString *title;

@end


NS_ASSUME_NONNULL_END
