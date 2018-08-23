//
//  DetailTopView.h
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetailTypeButtonBlock)(NSInteger index);

@interface DetailTopView : UIView

@property(nonatomic,strong)UILabel *commissionLab;

@property(nonatomic , strong)UIButton *firstBtn;
@property(nonatomic , strong)UIButton *secondBtn;
@property(nonatomic , strong)UIButton *thirdBtn;
@property(nonatomic , strong)UIButton *fourthBtn;
@property(nonatomic , strong)UIButton *fifthBtn;

@property(nonatomic , strong)UIView *moveLine;

@property(nonatomic , strong)DetailTypeButtonBlock detailTypeBlock;

- (instancetype)initWithType:(NSInteger)type;//0佣金明细 1提现明细

@end
