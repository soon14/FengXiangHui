//
//  IntegralRecordResultModel.h
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRecordResultModel : NSObject

/** list */
@property(nonatomic , strong)NSArray *list;

@end


@interface IntegralRecordResultListModel : NSObject

/** id */
@property(nonatomic , copy)NSString *recordID;
/** 订单号 */
@property(nonatomic , copy)NSString *logno;
/** 商品id */
@property(nonatomic , copy)NSString *goodsid;
/** status */
@property(nonatomic , copy)NSString *status;
/** eno */
@property(nonatomic , copy)NSString *eno;
/** paystatus */
@property(nonatomic , copy)NSString *paystatus;
/** title */
@property(nonatomic , copy)NSString *title;
/** type */
@property(nonatomic , copy)NSString *type;
/** 图片 */
@property(nonatomic , copy)NSString *thumb;
/** credit */
@property(nonatomic , copy)NSString *credit;
/** money */
@property(nonatomic , copy)NSString *money;
/** isverify */
@property(nonatomic , copy)NSString *isverify;
/** goodstype */
@property(nonatomic , copy)NSString *goodstype;
/** 地址 id */
@property(nonatomic , copy)NSString *addressid;
/** storeid */
@property(nonatomic , copy)NSString *storeid;
/** time_send */
@property(nonatomic , copy)NSString *time_send;
/** time_finish */
@property(nonatomic , copy)NSString *time_finish;
/** iscomment */
@property(nonatomic , copy)NSString *iscomment;
/** optiontitleg */
@property(nonatomic , copy)NSString *optiontitleg;
/** merchid */
@property(nonatomic , copy)NSString *merchid;
/** acttype */
@property(nonatomic , copy)NSString *acttype;
/** isreply */
@property(nonatomic , copy)NSString *isreply;
/** 状态 */
@property(nonatomic , copy)NSString *statust;

@end


NS_ASSUME_NONNULL_END
