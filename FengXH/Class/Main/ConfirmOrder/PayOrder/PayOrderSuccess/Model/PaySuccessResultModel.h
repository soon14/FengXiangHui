//
//  PaySuccessResultModel.h
//  FengXH
//
//  Created by sun on 2018/8/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PaySuccessResultDataModel,PaySuccessResultDataAddressModel;

@interface PaySuccessResultModel : NSObject

/** result */
@property(nonatomic , copy)NSString *result;
/** data */
@property(nonatomic , strong)PaySuccessResultDataModel *data;

@end


@interface PaySuccessResultDataModel : NSObject

/** address */
@property(nonatomic , strong)PaySuccessResultDataAddressModel *address;
/** price */
@property(nonatomic , copy)NSString *price;
/** virtualsendcontent */
@property(nonatomic , copy)NSString *virtualsendcontent;

@end



@interface PaySuccessResultDataAddressModel : NSObject

/** name */
@property(nonatomic , copy)NSString *name;
/** mobile */
@property(nonatomic , copy)NSString *mobile;

@end





