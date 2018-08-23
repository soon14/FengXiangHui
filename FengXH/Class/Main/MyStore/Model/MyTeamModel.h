//
//  MyTeamModel.h
//  FengXH
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTeamModel : NSObject
//list列表
@property(nonatomic,strong)NSArray *list;
//每页条数
@property(nonatomic,assign)NSInteger pagesize;
//总数据条数
@property(nonatomic,assign)NSInteger total;

@end


@interface MyTeamDataModel : NSObject
//名字
@property(nonatomic,copy)NSString *nickname;
//
@property(nonatomic,assign)BOOL isagent;
//
@property(nonatomic,assign)NSInteger status;
//电话
@property(nonatomic,copy)NSString *mobile;
//头像
@property(nonatomic,copy)NSString *avatar;
//1代表已成为店主的成员
@property(nonatomic,assign)NSInteger icon;
//成为店主时间
@property(nonatomic,copy)NSString *texts_agent;
//赚多少钱
@property(nonatomic,copy)NSString *commission_total;
//成员数量
@property(nonatomic,copy)NSString *agentcount;

@end
