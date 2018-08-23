//
//  SpellOrderDetailAddressCell.h
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpellOrderDetailAddressModel;

@interface SpellOrderDetailAddressCell : UITableViewCell
//0 物流  1收货地址
@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)SpellOrderDetailAddressModel *dataModel;

@end
