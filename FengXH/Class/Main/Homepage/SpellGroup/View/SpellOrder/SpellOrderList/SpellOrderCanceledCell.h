//
//  SpellOrderCanceledCell.h
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpellOrderListDataModel;

typedef void (^SpellOrderCanceledCellBlock)(void);
@interface SpellOrderCanceledCell : UITableViewCell

@property(nonatomic,strong)SpellOrderListDataModel *dataModel;

@property(nonatomic,copy)SpellOrderCanceledCellBlock btnClickBlock;

@end
