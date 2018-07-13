//
//  PersonalThirdCell.h
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCellItem.h"
typedef void (^PersonalThirdCellBlock)(NSInteger index);

@interface PersonalThirdCell : UITableViewCell

/** 待付款 */
@property(nonatomic , strong)PersonalCellItem *waitPayItem;
/** 待发货 */
@property(nonatomic , strong)PersonalCellItem *waitSendItem;
/** 待收货 */
@property(nonatomic , strong)PersonalCellItem *waitReceiveItem;
/** 退换货 */
@property(nonatomic , strong)PersonalCellItem *refundingItem;
/** 购物车 */
@property(nonatomic , strong)PersonalCellItem *shopCartItem;
/** block */
@property(nonatomic , strong)PersonalThirdCellBlock cellClickBlock;

@end
