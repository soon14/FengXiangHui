//
//  GoodsListFilterCell.h
//  FengXH
//
//  Created by sun on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AllCategoryDataResultModel,AllCategoryDataChildrenModel;

@interface GoodsListFilterCell : UITableViewCell

/** 一级分类模型 */
@property(nonatomic , strong)AllCategoryDataResultModel *resultModel;
/** 二级分类模型 */
@property(nonatomic , strong)AllCategoryDataChildrenModel *childrenModel;

@end
