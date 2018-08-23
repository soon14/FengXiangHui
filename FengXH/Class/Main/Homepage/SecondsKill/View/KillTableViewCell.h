//
//  KillTableViewCell.h
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondsKillModel;
@interface KillTableViewCell : UITableViewCell
/** 数据模型 */
@property(nonatomic , strong)SecondsKillModel *secondsKillModel;
@end
