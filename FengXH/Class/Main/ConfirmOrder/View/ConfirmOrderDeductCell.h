//
//  ConfirmOrderDeductCell.h
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConfirmOrderCreatResultModel;

typedef void (^DeductCellSwitchBlock)(UISwitch *sender);

@interface ConfirmOrderDeductCell : UITableViewCell

/** model */
@property(nonatomic , strong)ConfirmOrderCreatResultModel *resultModel;
/** block */
@property(nonatomic , strong)DeductCellSwitchBlock switchBlock;

@end
