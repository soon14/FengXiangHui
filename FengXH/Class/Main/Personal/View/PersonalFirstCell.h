//
//  PersonalFirstCell.h
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonalDataModel;

typedef void (^PersonalFirstCellBlock)(NSInteger index);

@interface PersonalFirstCell : UITableViewCell

/** block */
@property(nonatomic , strong)PersonalFirstCellBlock cellClickBlock;
/** 数据模型 */
@property(nonatomic , strong)PersonalDataModel *personalDataModel;

@end
