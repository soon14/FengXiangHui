//
//  CheckAfterSaleBottomView.h
//  FengXH
//
//  Created by sun on 2018/8/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CheckAfterSaleBottomViewBlock)(NSInteger index);

@interface CheckAfterSaleBottomView : UIView

/** block */
@property(nonatomic , strong)CheckAfterSaleBottomViewBlock viewBlock;

@end
