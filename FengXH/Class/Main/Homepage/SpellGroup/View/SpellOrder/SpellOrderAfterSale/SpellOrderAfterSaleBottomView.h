//
//  SpellOrderAfterSaleBottomView.h
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SpellOrderAfterSaleBottomBlock)(NSInteger index);

@interface SpellOrderAfterSaleBottomView : UIView

@property(nonatomic,copy)SpellOrderAfterSaleBottomBlock btnBlock;

@end
