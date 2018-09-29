//
//  IntegralExchangeResultModel.h
//  FengXH
//
//  Created by  on 2018/9/27.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IntegralExchangeResultMemberModel;

NS_ASSUME_NONNULL_BEGIN

@interface IntegralExchangeResultModel : NSObject

/** 个人信息 */
@property(nonatomic , strong)IntegralExchangeResultMemberModel *member;
/** list */
@property(nonatomic , strong)NSArray *list;

@end



@interface IntegralExchangeResultMemberModel : NSObject

/** id */
@property(nonatomic , copy)NSString *memberID;
/** 昵称 */
@property(nonatomic , copy)NSString *nickname;
/** 头像 */
@property(nonatomic , copy)NSString *avatar;
/** commissionlevelname */
@property(nonatomic , copy)NSString *commissionlevelname;
/** 积分 */
@property(nonatomic , copy)NSString *credit;
/** credittext */
@property(nonatomic , copy)NSString *credittext;

@end



@interface IntegralExchangeResultListModel : NSObject

/** id */
@property(nonatomic , copy)NSString *listID;
/** 商品 id */
@property(nonatomic , copy)NSString *goodsid;
/** title */
@property(nonatomic , copy)NSString *title;
/** 图片 */
@property(nonatomic , copy)NSString *thumb;
/** 消耗积分 */
@property(nonatomic , copy)NSString *credit;
/** type */
@property(nonatomic , copy)NSString *type;
/** 消耗金额 */
@property(nonatomic , copy)NSString *money;
/** 时间 */
@property(nonatomic , copy)NSString *createtime;
/** status */
@property(nonatomic , copy)NSString *status;
/** acttype */
@property(nonatomic , copy)NSString *acttype;
/** statust */
@property(nonatomic , copy)NSString *statust;

@end

NS_ASSUME_NONNULL_END
