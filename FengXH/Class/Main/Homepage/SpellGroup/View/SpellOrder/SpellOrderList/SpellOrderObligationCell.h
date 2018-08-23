//
//  SpellOrderObligationCell.h
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpellOrderListDataModel;

typedef void (^SpellOrderObligationCellBlock)(NSInteger index) ;

@interface SpellOrderObligationCell : UITableViewCell

@property(nonatomic,strong)SpellOrderListDataModel *dataModel;

@property(nonatomic,copy)SpellOrderObligationCellBlock btnClickBlock;

@end
