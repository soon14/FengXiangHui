//
//  SpellOrderCompletedCell.h
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpellOrderListDataModel;

typedef void (^SpellOrderCompletedCellBlock)(NSInteger index);

@interface SpellOrderCompletedCell : UITableViewCell

@property(nonatomic,strong)SpellOrderListDataModel *dataModel;

@property(nonatomic,copy)SpellOrderCompletedCellBlock btnClickBlock;

@end
