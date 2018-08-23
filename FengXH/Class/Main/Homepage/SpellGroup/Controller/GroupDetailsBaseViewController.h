//
//  GroupDetailsBaseViewController.h
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@interface GroupDetailsBaseViewController : BaseViewController
- (instancetype)initWithType:(NSInteger)type;
@property (nonatomic ,strong) NSDictionary *dic;
@end
