//
//  GoodsListFilterViewController.h
//  FengXH
//
//  Created by sun on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PopupViewController.h"

typedef void (^PopupViewControllerBlock)(NSInteger index);
typedef void (^PopupViewControllerConfirmBlock)(NSString *isrecommand ,NSString *isnew ,NSString *ishot, NSString *isdiscount, NSString *issendfree, NSString *istime);

@interface GoodsListFilterViewController : PopupViewController

/** 取消按钮 block */
@property(nonatomic , strong)PopupViewControllerBlock takeBackBlock;
/** 确定按钮 block */
@property(nonatomic , strong)PopupViewControllerConfirmBlock confirmBlock;

@end

