//
//  HomePageSecondKillCell.h
//  FengXH
//
//  Created by sun on 2018/10/12.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HomepageResultSeckillgroupModel,HomePageSecondKillCell,HomepageResultCommodityModel;

@protocol HomePageSecondKillCellDelegate <NSObject>
- (void)HomePageSecondKillCell:(HomePageSecondKillCell *)cell didClickMoreButton:(HomepageResultSeckillgroupModel *)secondKillModel;
- (void)HomePageSecondKillCell:(HomePageSecondKillCell *)cell didSelectGoodsItemWith:(HomepageResultCommodityModel *)secondKillGoodsModel;
@end

@interface HomePageSecondKillCell : UICollectionViewCell

/** 数据模型 */
@property(nonatomic , strong)HomepageResultSeckillgroupModel *secondKillModel;
/** 代理 */
@property(nonatomic , weak)id <HomePageSecondKillCellDelegate> delegate;

@end




@interface HomePageSecondKillGoodsCell : UICollectionViewCell

/** 模型 */
@property(nonatomic , strong)HomepageResultCommodityModel *goodsModel;

@end

NS_ASSUME_NONNULL_END
