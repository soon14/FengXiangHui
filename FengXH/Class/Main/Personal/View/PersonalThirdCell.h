//
//  PersonalThirdCell.h
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonalDataStaticsModel;

typedef void (^PersonalThirdCellBlock)(NSInteger index);

@interface PersonalThirdCell : UITableViewCell

/** block */
@property(nonatomic , strong)PersonalThirdCellBlock cellClickBlock;
/** 我的订单数量 */
@property(nonatomic , strong)PersonalDataStaticsModel *staticsModel;

@end
