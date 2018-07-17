//
//  HomePageFunctionCell.h
//  FengXH
//
//  Created by 孙湖滨 on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomepageDataMenuDataModel,HomePageFunctionCell;

@protocol HomePageFunctionDelegate <NSObject>
- (void)HomePageFunctionCell:(HomePageFunctionCell *)cell didSelectFunctiomItemWith:(HomepageDataMenuDataModel *)functionItemModel;
@end

@interface HomePageFunctionCell : UICollectionViewCell

/** 数组 */
@property(nonatomic , strong)NSArray <HomepageDataMenuDataModel *> *menuDataArray;
/** 代理 */
@property (weak , nonatomic) id <HomePageFunctionDelegate> delegate;

@end


@interface HomePageFunctionItemCell : UICollectionViewCell
/** functionItem模型 */
@property(nonatomic , strong)HomepageDataMenuDataModel *functionItemModel ;
@end
