//
//  GoodsListPopupView.h
//  GoodsListPopup_demo
//
//  Created by sun on 2018/8/28.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBPopupView : UIView

/** View */
@property(nonatomic , strong)UIView *contentView;
/** contetView height */
@property(nonatomic , assign)CGFloat contentHeight;

- (void)showInView:(UIView *)view;

- (void)removeView ;

@end
