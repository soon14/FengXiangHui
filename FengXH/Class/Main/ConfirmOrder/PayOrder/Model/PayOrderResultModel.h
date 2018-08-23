//
//  PayOrderResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayOrderResultModel : NSObject

/** orderid */
@property(nonatomic , copy)NSString *orderid;
/** ordersn */
@property(nonatomic , copy)NSString *ordersn;
/** price */
@property(nonatomic , copy)NSString *price;

@end
