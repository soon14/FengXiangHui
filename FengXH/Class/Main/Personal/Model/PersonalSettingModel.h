//
//  PersonalSettingModel.h
//  FengXH
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalSettingModel : NSObject
//用户id
@property(nonatomic,copy)NSString *userId;
//真实名字
@property(nonatomic,copy)NSString *realname;
//手机号
@property(nonatomic,copy)NSString *mobile;
//密码
@property(nonatomic,copy)NSString *pwd;
//注册时间
@property(nonatomic,copy)NSString *createtime;
//昵称
@property(nonatomic,copy)NSString *nickname;
//出生年
@property(nonatomic,copy)NSString *birthyear;
//出生月
@property(nonatomic,copy)NSString *birthmonth;
//出生日
@property(nonatomic,copy)NSString *birthday;
//头像
@property(nonatomic,copy)NSString *avatar;
//省
@property(nonatomic,copy)NSString *province;
//市
@property(nonatomic,copy)NSString *city;
//区
@property(nonatomic,copy)NSString *area;
//微信号
@property(nonatomic,copy)NSString *weixin;
//微信昵称
@property(nonatomic,copy)NSString *nickname_wechat;
//微信头像
@property(nonatomic,copy)NSString *avatar_wechat;

@end
