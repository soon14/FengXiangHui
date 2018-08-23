//
//  AddressCreatEditViewController.h
//  FengXH
//
//  Created by sun on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"
@class AddressResultListModel;

typedef void (^AddressSaveSuccessBlock)(NSInteger index);

@interface AddressCreatEditViewController : BaseViewController

/** 要编辑的地址 */
@property(nonatomic , strong)AddressResultListModel *editAddressModel;
/** 保存成功后的回调 */
@property(nonatomic , strong)AddressSaveSuccessBlock savcSuccessBlock;

@end
