//
//  IntegralGoodsDetailBottomView.h
//  FengXH
//
//  Created by sun on 2018/9/29.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class IntegralGoodsDetailResultModel,IntegralGoodsDetailBottomView;
@protocol IntegralGoodsDetailBottomViewDelegate <NSObject>

#pragma mark - 立即兑换
- (void)IntegralGoodsDetailBottomView:(IntegralGoodsDetailBottomView *)view;

@end

@interface IntegralGoodsDetailBottomView : UIView

/** model */
@property(nonatomic , strong)IntegralGoodsDetailResultModel *detailResultModel;
/** delegate */
@property(nonatomic , weak)id <IntegralGoodsDetailBottomViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
