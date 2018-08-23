//
//  StoreCommissionCell.h
//  FengXH
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreModel;

typedef void (^CommissionCellBlock)(void);

@interface StoreCommissionCell : UICollectionViewCell

@property(nonatomic,strong)StoreModel *storeCommissionData;

@property(nonatomic,copy)CommissionCellBlock commissionBlock;

@end
