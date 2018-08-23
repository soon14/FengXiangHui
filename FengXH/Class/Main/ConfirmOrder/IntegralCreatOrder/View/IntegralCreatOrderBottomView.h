//
//  IntegralCreatOrderBottomView.h
//  FengXH
//
//  Created by sun on 2018/8/22.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IntegralCreatOrderResultModel;

typedef void (^IntegralCreatOrderPayBlock)(UIButton *sender);

@interface IntegralCreatOrderBottomView : UIView

/** model */
@property(nonatomic , strong)IntegralCreatOrderResultModel *resultModel;
/** block */
@property(nonatomic , strong)IntegralCreatOrderPayBlock integralPayBlock;

@end
