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
- (void)GoodsDetailBottomView:(GoodsDetailBottomView *)bottomView buttonAction:(UIButton *)sender;
@end

@interface GoodsDetailBottomView : UIView

/** 代理 */
@property(nonatomic , weak)id delegate;
/** 是否收藏 */
@property(nonatomic , assign)BOOL isFavorite;

@end
