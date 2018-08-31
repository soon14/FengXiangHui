//
//  MyStoreResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyStoreResultModel : NSObject

//头像
@property(nonatomic,copy)NSString *avatar;
//名字
@property(nonatomic,copy)NSString *nickname;
//推荐人名字
@property(nonatomic,copy)NSString *upmember;
//推荐人头像
@property(nonatomic,copy)NSString *uavatar;
//推荐人电话
@property(nonatomic,copy)NSString *umobile;
//邀请码
@property(nonatomic,copy)NSString *mid;

//可提现得佣金
@property(nonatomic,copy)NSString *canwithdraw;
//成功提现得佣金
@property(nonatomic,copy)NSString *successwithdraw;

//店主佣金
@property(nonatomic,copy)NSString *withdraw;
//佣金明细
@property(nonatomic,copy)NSString *order;
//提现明细
@property(nonatomic,copy)NSString *log;
//我的团队
@property(nonatomic,copy)NSString *down;

@end
