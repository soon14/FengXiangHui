//
//  GoodsListFilterViewController.h
//  FengXH
//
//  Created by sun on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PopupViewController.h"
@class AllCategoryDataModel;
typedef void (^PopupViewControllerBlock)(NSInteger index);
typedef void (^PopupViewControllerConfirmBlock)(NSString *isrecommand ,NSString *isnew ,NSString *ishot, NSString *isdiscount, NSString *issendfree, NSString *istime, NSString *categoryID);

@interface GoodsListFilterViewController : PopupViewController

/** 全部商品分类的数据模型 */
@property(nonatomic , strong)AllCategoryDataModel *categoryDataModel;
/** 取消按钮 block */
@property(nonatomic , strong)PopupViewControllerBlock takeBackBlock;
/** 确定按钮 block */
@property(nonatomic , strong)PopupViewControllerConfirmBlock confirmBlock;

@end

