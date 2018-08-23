//
//  PaySuccessFooterView.h
//  FengXH
//
//  Created by sun on 2018/8/21.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PaySuccessFooterBlock)(UIButton *sender);

@interface PaySuccessFooterView : UIView

/** block */
@property(nonatomic , strong)PaySuccessFooterBlock backBlock;

@end
