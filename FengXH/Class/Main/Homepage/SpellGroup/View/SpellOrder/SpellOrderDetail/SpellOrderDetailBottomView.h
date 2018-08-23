//
//  SpellOrderDetailBottomView.h
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SpellOrderDetailBottomBlock)(NSInteger index);

@interface SpellOrderDetailBottomView : UIView

@property(nonatomic,copy)SpellOrderDetailBottomBlock btnBlock;

-(instancetype)initWithType:(NSInteger)type  andFrame:(CGRect)frame;

@end
