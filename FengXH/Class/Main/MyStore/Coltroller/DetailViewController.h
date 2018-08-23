//
//  DetailViewController.h
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController

@property(nonatomic,assign)NSInteger detailType;

- (instancetype)initWithType:(NSInteger)type;

@end
