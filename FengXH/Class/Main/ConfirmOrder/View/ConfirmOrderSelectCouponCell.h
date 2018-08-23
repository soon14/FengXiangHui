//
//  ConfirmOrderSelectCouponCell.h
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConfirmOrderCouponResultListModel;

typedef void (^CellCouponSelectedBlock)(ConfirmOrderCouponResultListModel *couponModel, BOOL selected);

@interface ConfirmOrderSelectCouponCell : UITableViewCell

/** listModel */
@property(nonatomic , strong)ConfirmOrderCouponResultListModel *couponModel;
/** block */
@property(nonatomic , strong)CellCouponSelectedBlock couponSelectedBlock;

@end
