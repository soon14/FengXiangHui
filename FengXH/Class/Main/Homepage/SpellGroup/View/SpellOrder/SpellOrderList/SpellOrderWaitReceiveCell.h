//
//  SpellOrderWaitReceiveCell.h
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpellOrderListDataModel;

typedef void (^SpellOrderWaitReceiveCellBlock)(NSInteger index);

@interface SpellOrderWaitReceiveCell : UITableViewCell

@property(nonatomic,strong)SpellOrderListDataModel *dataModel;

@property(nonatomic,copy)SpellOrderWaitReceiveCellBlock btnClickBlock;

@end
