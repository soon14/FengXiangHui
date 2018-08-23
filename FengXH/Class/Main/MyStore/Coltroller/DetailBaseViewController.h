//
//  DetailBaseViewController.h
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@class DetailTopView;

@interface DetailBaseViewController : BaseViewController

@property(nonatomic , strong)DetailTopView *topButtonView;


- (instancetype)initWithType:(NSInteger)type;

@end
