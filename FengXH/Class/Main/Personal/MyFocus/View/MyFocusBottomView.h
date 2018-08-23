//
//  MyFocusBottomView.h
//  FengXH
//
//  Created by sun on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyFocusBottomViewBlock)(UIButton *sender);

@interface MyFocusBottomView : UIView

/** block */
@property(nonatomic , strong)MyFocusBottomViewBlock buttonClickBlock;

@end
