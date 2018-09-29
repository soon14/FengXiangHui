//
//  IntegralBaseHeaderView.h
//  FengXH
//
//  Created by sun on 2018/9/26.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonalDataModel;

NS_ASSUME_NONNULL_BEGIN
typedef void (^IntegralBaseHeaderViewBlock)(NSInteger index);

@interface IntegralBaseHeaderView : UIView

/** 积分商城 */
@property(nonatomic , strong)UIButton *integralMallButton;
/** 积分兑换 */
@property(nonatomic , strong)UIButton *integralExchangeButton;
/** 兑换记录 */
@property(nonatomic , strong)UIButton *exchangeRecordButton;
/** model */
@property(nonatomic , strong)PersonalDataModel *personalDataModel;
/** block */
@property(nonatomic , strong)IntegralBaseHeaderViewBlock headerBlock;

@end

NS_ASSUME_NONNULL_END
