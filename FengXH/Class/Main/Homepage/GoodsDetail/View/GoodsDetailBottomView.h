//
//  GoodsDetailBottomView.h
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailBottomView;

@protocol GoodsDetailBottomViewDelegate <NSObject>
- (void)GoodsDetailBottomView:(GoodsDetailBottomView *)bottomView buttonAction:(NSInteger)index;
@end

@interface GoodsDetailBottomView : UIView

/** 代理 */
@property(nonatomic , weak)id delegate;

@end
