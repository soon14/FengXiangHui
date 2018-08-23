//
//  MyFootprintBottomView.h
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyFootprintBottomViewBlock)(UIButton *sender);

@interface MyFootprintBottomView : UIView

/** block */
@property(nonatomic , strong)MyFootprintBottomViewBlock buttonClickBlock;

@end
