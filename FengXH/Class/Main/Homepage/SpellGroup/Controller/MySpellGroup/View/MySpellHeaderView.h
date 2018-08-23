//
//  MySpellHeaderView.h
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SpellTypeButtonBlock)(NSInteger index);

@interface MySpellHeaderView : UIView

@property(nonatomic , strong)UIButton *firstBtn;
@property(nonatomic , strong)UIButton *secondBtn;
@property(nonatomic , strong)UIButton *thirdBtn;
@property(nonatomic , strong)UIButton *fourthBtn;
@property(nonatomic , strong)UIButton *fifthBtn;

@property(nonatomic , strong)UIView *moveLine;

@property(nonatomic , strong)SpellTypeButtonBlock spellTypeBlock;

- (instancetype)initWithType:(NSInteger)type;//0我的订单 1我的团

@end
