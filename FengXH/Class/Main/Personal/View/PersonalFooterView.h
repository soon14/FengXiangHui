//
//  PersonalFooterView.h
//  FengXH
//
//  Created by sun on 2018/7/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PersonalFooterViewBlock)(NSInteger index);

@interface PersonalFooterView : UIView

/** block */
@property(nonatomic , strong)PersonalFooterViewBlock clickBlock;

@end
