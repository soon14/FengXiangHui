//
//  GoodsDetailNavigationView.h
//  FengXH
//
//  Created by sun on 2018/9/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailNavigationView;

@protocol GoodsDetailNavigationViewDelegate <NSObject>
- (void)GoodsDetailNavigationView:(GoodsDetailNavigationView *)navigationView buttonAction:(NSInteger)index;
@end

@interface GoodsDetailNavigationView : UIView

/** 商品 */
@property(nonatomic , strong)UIButton *goodsButton;
/** 详情 */
@property(nonatomic , strong)UIButton *detailsButton;
/** 移动光标 */
@property(nonatomic , strong)UIView *moveLine;
/** delegate */
@property(nonatomic , weak)id <GoodsDetailNavigationViewDelegate> delegate;

@end
