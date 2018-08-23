//
//  CheckAfterSaleViewController.h
//  FengXH
//
//  Created by sun on 2018/8/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^CheckAfterSaleSuccessBlock)();

@interface CheckAfterSaleViewController : BaseViewController

/** orderid */
@property(nonatomic , copy)NSString *orderID;
/** block */
@property(nonatomic , strong)CheckAfterSaleSuccessBlock cancelAfterSaleSuccessBlock;

@end
