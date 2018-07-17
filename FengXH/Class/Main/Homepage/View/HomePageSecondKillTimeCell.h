//
//  HomePageSecondKillCell.h
//  FengXH
//
//  Created by sun on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomepageDataSecondKillModel,HomePageSecondKillTimeCell;

@protocol HomePageSecondKillTimeDelegate <NSObject>
- (void)HomePageSecondKillTimeCell:(HomePageSecondKillTimeCell *)cell didClickMoreButton:(HomepageDataSecondKillModel *)secondKillModel;
@end

@interface HomePageSecondKillTimeCell : UICollectionViewCell

/** 数据模型 */
@property(nonatomic , strong)HomepageDataSecondKillModel *secondKillModel;
/** 代理 */
@property(nonatomic , weak)id <HomePageSecondKillTimeDelegate> delegate;

@end
