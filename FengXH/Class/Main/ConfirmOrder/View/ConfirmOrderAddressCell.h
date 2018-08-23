//
//  ConfirmOrderCreatAddressCell.h
//  FengXH
//
//  Created by sun on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressResultListModel;

@interface ConfirmOrderAddressCell : UITableViewCell

/** 地址模型 */
@property(nonatomic , strong)AddressResultListModel *addressModel;

@end
