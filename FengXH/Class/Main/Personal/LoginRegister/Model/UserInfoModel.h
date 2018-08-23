//
//  UserInfoModel.h
//  FengXH
//
//  Created by sun on 2018/7/23.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

/** id */
@property(nonatomic , copy)NSString *userid;
/** mobile */
@property(nonatomic , copy)NSString *mobile;
/** openid */
@property(nonatomic , copy)NSString *openid;
/** salt */
@property(nonatomic , copy)NSString *salt;
/** pwd */
@property(nonatomic , copy)NSString *pwd;
/** token */
@property(nonatomic , copy)NSString *token;
/** url */
@property(nonatomic , copy)NSString *url;

@end
