//
//  SignInResultModel.h
//  FengXH
//
//  Created by sun on 2018/10/9.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SignInResultMemberModel,SignInResultAdvawardModel;
@interface SignInResultModel : NSObject

/** 标题 */
@property(nonatomic , copy)NSString *title;
/** 类型 */
@property(nonatomic , copy)NSString *textsign;
/** 连续多少天 */
@property(nonatomic , assign)NSInteger orderday;
/** 积分 */
@property(nonatomic , copy)NSString *textcredit;
/** 不为空可补签 */
@property(nonatomic , copy)NSString *signold;
/** 补签扣除多少 */
@property(nonatomic , copy)NSString *signoldprice;
/** 补签扣积分、余额 */
@property(nonatomic , copy)NSString *signoldtype;
/** 补签提示 */
@property(nonatomic , copy)NSString *signolds;
/** 为空 未签到 */
@property(nonatomic , copy)NSString *haveSigned;
/** 今日已签 */
@property(nonatomic , copy)NSString *textsigned;
/** 总天数 */
@property(nonatomic , assign)NSInteger sum;
/** 用户信息 */
@property(nonatomic , strong)SignInResultMemberModel *member;
/** 已签到的数组 */
@property(nonatomic , strong)NSArray *calendar;
/** 连续签到奖励 */
@property(nonatomic , strong)SignInResultAdvawardModel *advaward;

@end



@interface SignInResultMemberModel : NSObject

/** 用户 id */
@property(nonatomic , copy)NSString *memberID;
/** 头像 */
@property(nonatomic , copy)NSString *avatar;
/** 昵称 */
@property(nonatomic , copy)NSString *nickname;
/** 积分 */
@property(nonatomic , assign)NSInteger credit1;

@end



@interface SignInResultCalendarModel : NSObject

/** 年 */
@property(nonatomic , copy)NSString *year;
/** 月 */
@property(nonatomic , copy)NSString *month;
/** 日 */
@property(nonatomic , assign)NSInteger day;
/** 时间 */
@property(nonatomic , copy)NSString *date;
/** 1为已签到 */
@property(nonatomic , copy)NSString *haveSigned;
/** signold */
@property(nonatomic , copy)NSString *signold;
/** 不为空显示 日期标题 */
@property(nonatomic , copy)NSString *title;
/**  */
@property(nonatomic , copy)NSString *today;

@end



@interface SignInResultAdvawardModel : NSObject

/** 连续签到 奖励 未开启为空  不显示 */
@property(nonatomic , strong)NSArray *order;
/** sum */
@property(nonatomic , copy)NSString *sum;

@end



@interface SignInResultAdvawardOrderModel : NSObject

/** day */
@property(nonatomic , copy)NSString *day;
/** credit */
@property(nonatomic , assign)NSInteger credit;
/** 领取按钮是否出现 */
@property(nonatomic , copy)NSString *candraw;
/** 是否可领取 */
@property(nonatomic , copy)NSString *drawed;


@end

NS_ASSUME_NONNULL_END
