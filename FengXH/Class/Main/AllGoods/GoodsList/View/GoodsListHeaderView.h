//
//  GoodsListHeaderView.h
//  FengXH
//
//  Created by sun on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GoodsListHeaderViewBlock)(NSInteger index);

@interface GoodsListHeaderView : UIView

/** textField */
@property(nonatomic , strong)UITextField *searchTextField;
/** layoutButton */
@property(nonatomic , strong)UIButton *layoutButton;

/** 综合按钮 */
@property(nonatomic , strong)UIButton *synthesizeButton;
/** 销量按钮 */
@property(nonatomic , strong)UIButton *salesButton;
/** 价格按钮 */
@property(nonatomic , strong)UIButton *priceButton;
/** 筛选按钮 */
@property(nonatomic , strong)UIButton *filtrateButton;

/** block */
@property(nonatomic , strong)GoodsListHeaderViewBlock headerViewBlock;

@end
