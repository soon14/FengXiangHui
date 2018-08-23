//
//  ConfirmOrderSelectCouponView.h
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConfirmOrderCouponResultModel,ConfirmOrderCouponResultListModel;

typedef void (^CouponSelectedBlock)(ConfirmOrderCouponResultListModel *couponModel);

@interface ConfirmOrderSelectCouponView : UIView

/** couponModel */
@property(nonatomic , strong)ConfirmOrderCouponResultModel *couponResultModel;
/** block */
@property(nonatomic , strong)CouponSelectedBlock couponSelectedBlock;

- (void)show;

- (void)closeView;

@end
