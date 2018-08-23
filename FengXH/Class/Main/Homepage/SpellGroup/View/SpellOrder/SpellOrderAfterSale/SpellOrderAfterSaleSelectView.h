//
//  SpellOrderAfterSaleSelectView.h
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpellOrderAfterSaleSelectView : UIView

@property(nonatomic,strong)NSArray *dataArr;//标题数组

//type  0处理方式 1退款原因
-(instancetype)initWithType:(NSInteger)type andFrame:(CGRect)frame;

@end
