//
//  RightCollectionViewCell.h
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllCategoryDataModel.h"

@interface AllGoodsRightCollectionViewCell : UICollectionViewCell

/** 数据模型 */
@property(nonatomic , strong)AllCategoryDataChildrenModel *categoryChildrenModel;

@end
