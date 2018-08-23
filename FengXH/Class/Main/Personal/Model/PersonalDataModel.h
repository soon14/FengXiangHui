//
//  PersonalDataModel.h
//  FengXH
//
//  Created by  on 2018/7/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonalDataStaticsModel;

@interface PersonalDataModel : NSObject

/** 头像地址 */
@property(nonatomic , copy)NSString *avatar;
/** 学院图标 */
@property(nonatomic , strong)NSArray *college;
/** 用户积分 */
@property(nonatomic , copy)NSString *credit1;
/** 用户余额 */
@property(nonatomic , copy)NSString *credit2;
/** 用户 id */
@property(nonatomic , copy)NSString *userID;
/** 等级 */
@property(nonatomic , copy)NSString *levelname;
/** 昵称 */
@property(nonatomic , copy)NSString *nickname;
/** 各种订单数量 */
@property(nonatomic , strong)PersonalDataStaticsModel *statics;

@end


@interface PersonalDataCollegeModel : NSObject

/** 图 */
@property(nonatomic , copy)NSString *imgurl;
/** 字 */
@property(nonatomic , copy)NSString *text;

@end

/** 各种订单数量 */
@interface PersonalDataStaticsModel : NSObject

/** 购物车数量 */
@property(nonatomic , assign)NSInteger cart;
/** 优惠券数量 */
@property(nonatomic , assign)NSInteger coupon;
/** 我的收藏数量 */
@property(nonatomic , assign)NSInteger favorite;
/** 待付款 */
@property(nonatomic , assign)NSInteger order_0;
/** 待发货 */
@property(nonatomic , assign)NSInteger order_1;
/** 待收货 */
@property(nonatomic , assign)NSInteger order_2;
/** 退换货 */
@property(nonatomic , assign)NSInteger order_4;

@end
