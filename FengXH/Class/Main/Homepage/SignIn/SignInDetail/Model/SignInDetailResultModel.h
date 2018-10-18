//
//  SignInDetailResultModel.h
//  FengXH
//
//  Created by sun on 2018/10/8.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SignInDetailResultTextsModel;
@interface SignInDetailResultModel : NSObject

/** text */
@property(nonatomic , strong)SignInDetailResultTextsModel *texts;
/** array */
@property(nonatomic , strong)NSArray *list;

@end



@interface SignInDetailResultTextsModel : NSObject

/** 签到 */
@property(nonatomic , copy)NSString *sign;
/** 已签 */
@property(nonatomic , copy)NSString *haveSigned;
/** 补签 */
@property(nonatomic , copy)NSString *signold;
/** 积分 */
@property(nonatomic , copy)NSString *credit;

@end



@interface SignInDetailResultListModel : NSObject

/** id */
@property(nonatomic , copy)NSString *listID;
/** 签到时间戳 */
@property(nonatomic , copy)NSString *time;
/** 积分 */
@property(nonatomic , assign)NSInteger credit;
/** 文字描述 */
@property(nonatomic , copy)NSString *log;
/** 奖励类型 0 日常 1 连续 2 总签到 */
@property(nonatomic , assign)NSInteger type;
/** 时间  2018-09-03 09:24:35 */
@property(nonatomic , copy)NSString *date;

@end

NS_ASSUME_NONNULL_END
