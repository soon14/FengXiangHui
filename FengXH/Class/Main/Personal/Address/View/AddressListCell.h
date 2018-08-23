//
//  AddressListCell.h
//  FengXH
//
//  Created by sun on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressResultListModel;

typedef void (^AddressListCellBlock)(NSInteger index, AddressResultListModel *addressModel);

@interface AddressListCell : UITableViewCell

/** Model */
@property(nonatomic , strong)AddressResultListModel *addressModel;
/** block */
@property(nonatomic , strong)AddressListCellBlock clickBlock;

@end
