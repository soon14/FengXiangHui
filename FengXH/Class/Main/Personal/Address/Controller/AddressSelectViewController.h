//
//  AddressSelectViewController.h
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressResultModel.h"

typedef void (^AddressSeclectedBlock)(AddressResultListModel *addressModel);

@interface AddressSelectViewController : BaseViewController

/** 上一级传入的地址 id 用于判断哪个地址被选择了*/
@property(nonatomic , strong)AddressResultListModel *selectAddressModel;
/** 地址选择回调block */
@property(nonatomic , strong)AddressSeclectedBlock addressSelectBlock;

@end
