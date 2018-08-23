//
//  AddressSelectCell.h
//  FengXH
//
//  Created by sun on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressResultListModel;

typedef void (^AddressEditBlock)(AddressResultListModel *addressModel);

@interface AddressSelectCell : UITableViewCell

/** 地址 Model */
@property(nonatomic , strong)AddressResultListModel *addressModel;
/** block */
@property(nonatomic , strong)AddressEditBlock editBlock;

@end
