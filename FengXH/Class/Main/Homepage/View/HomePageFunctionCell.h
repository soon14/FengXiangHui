//
//  HomePageFunctionCell.h
//  FengXH
//
//  Created by sun on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomepageResultPictureModel,HomePageFunctionCell;

@protocol HomePageFunctionDelegate <NSObject>
- (void)HomePageFunctionCell:(HomePageFunctionCell *)cell didSelectFunctiomItemWith:(HomepageResultPictureModel *)functionItemModel;
@end

@interface HomePageFunctionCell : UICollectionViewCell

/** 数组 */
@property(nonatomic , strong)NSArray <HomepageResultPictureModel *> *menuDataArray;
/** 代理 */
@property (weak , nonatomic) id <HomePageFunctionDelegate> delegate;

@end


@interface HomePageFunctionItemCell : UICollectionViewCell
/** functionItem模型 */
@property(nonatomic , strong)HomepageResultPictureModel *functionItemModel ;
@end
