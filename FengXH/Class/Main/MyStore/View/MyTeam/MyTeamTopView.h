//
//  MyTeamTopView.h
//  FengXH
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyTeamButtonBlock)(NSInteger index);

@interface MyTeamTopView : UIView
//一级店主
@property(nonatomic,strong)UIButton *stairShopkeeper;
//二级店主
@property(nonatomic,strong)UIButton *secondShopkeeper;

@property(nonatomic , strong)UIView *moveLine;

@property(nonatomic , strong)MyTeamButtonBlock myTeamBlock;

@end
