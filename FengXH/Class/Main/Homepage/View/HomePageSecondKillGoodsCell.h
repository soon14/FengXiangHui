//
//  HomePageSecondKillGoodsCell.h
//  FengXH
//
//  Created by sun on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageSecondKillGoodsCell,HomepageDataSecondKillGoodsModel;

@protocol HomePageSecondKillGoodsDelegate <NSObject>
- (void)HomePageSecondKillGoodsCell:(HomePageSecondKillGoodsCell *)cell didSelectGoodsItemWith:(HomepageDataSecondKillGoodsModel *)secondKillGoodsModel;
@end

@interface HomePageSecondKillGoodsCell : UICollectionViewCell

/** 模型数组 */
@property(nonatomic , strong)NSArray *goodsArray;
/** 代理 */
@property(nonatomic , weak)id <HomePageSecondKillGoodsDelegate> delegate;

@end



@interface HomePageSecondKillGoodsDetailCell : UICollectionViewCell

/** 模型 */
@property(nonatomic , strong)HomepageDataSecondKillGoodsModel *goodsModel;

@end
