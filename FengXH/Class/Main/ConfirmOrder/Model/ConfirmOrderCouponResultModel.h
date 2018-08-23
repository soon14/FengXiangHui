//
//  ConfirmOrderCouponResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfirmOrderCouponResultModel : NSObject

/** list */
@property(nonatomic , strong)NSArray *list;

@end


@interface ConfirmOrderCouponResultListModel : NSObject

/** 选择 */
@property(nonatomic , assign)BOOL selected;
/** id */
@property(nonatomic , copy)NSString *couponID;
/** backpre */
@property(nonatomic , copy)NSString *backpre;
/** 优惠多少或折扣多少 */
@property(nonatomic , copy)NSString *backmoney;
/** 显示折 */
@property(nonatomic , copy)NSString *backtype;
/** 标题 */
@property(nonatomic , copy)NSString *couponname;
/** 有效期 */
@property(nonatomic , copy)NSString *timestr;

@end
