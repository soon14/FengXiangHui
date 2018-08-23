//
//  GroupDetailsMenu.h
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SpellTypeButtonBlock)(NSInteger index);
@interface GroupDetailsMenu : UIView
@property(nonatomic , strong)UIButton *firstBtn;
@property(nonatomic , strong)UIButton *secondBtn;
@property(nonatomic , strong)UIView *moveLine;

@property(nonatomic , strong)SpellTypeButtonBlock spellTypeBlock;

- (instancetype)initWithType:(NSInteger)type;//0我的订单 1我的团
@end
