//
//  CheckAfterSaleResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckAfterSaleResultModel : NSObject

/** 退款金额 */
@property(nonatomic , copy)NSString *applyprice;
/** 退款说明 */
@property(nonatomic , copy)NSString *content;
/** 申请时间 */
@property(nonatomic , copy)NSString *createtime;
/** maxprice */
@property(nonatomic , copy)NSString *maxprice;
/** 卖家留言 */
@property(nonatomic , copy)NSString *message;
/** 退款原因 */
@property(nonatomic , copy)NSString *reason;
/** 换货地址 */
@property(nonatomic , copy)NSString *refundaddress;
/** 为空退款申请 无申请退款 */
@property(nonatomic , copy)NSString *refundstate;
/** 快递公司 */
@property(nonatomic , copy)NSString *rexpresscom;
/** 快递单号 */
@property(nonatomic , copy)NSString *rexpresssn;
/** 0退款 1退货 2换货
 //rtype=0 status=0  时 退款申请流程：1、发起退款申请 2、商家确认后退款到您的账户如果商家未处理：请及时与商家联系
 //或者 rtype=1     退款退货申请流程：1、发起退款退货申请2、退货需将退货商品邮寄至商家指定地址，并在系统内输入快递单号3、商家收货后确认无误4、退款到您的账户
 //或者rtype=2     换货申请流程：1、发起换货申请，并把快递单号录入系统2、将需要换货的商品邮寄至商家指定地址，并在系统内输入快递单号3、商家确认后货后重新发出商品4、签收确认
 */
@property(nonatomic , copy)NSString *rtype;
/** 0等待商家处理 >=3商家已经通过  （5商家已经发货  4等待商家确认 3需填写快递单） */
@property(nonatomic , copy)NSString *status;
/** 退款申请 否则为售后申请 */
@property(nonatomic , copy)NSString *status1;

@end
