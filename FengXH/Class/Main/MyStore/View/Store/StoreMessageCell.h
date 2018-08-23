//
//  StoreMessageCell.h
//  FengXH
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^StoreMessageCellBlock)(void);

@class StoreModel;

@interface StoreMessageCell : UICollectionViewCell
//数据模型
@property(nonatomic,strong)StoreModel *storeMessageData;
//block
@property(nonatomic , strong)StoreMessageCellBlock cellClickBlock;
@end
