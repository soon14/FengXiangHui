//
//  PaySuccessAddressCell.h
//  FengXH
//
//  Created by sun on 2018/8/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PaySuccessResultDataAddressModel;

@interface PaySuccessAddressCell : UITableViewCell

/** model */
@property(nonatomic , strong)PaySuccessResultDataAddressModel *successAddressModel;

@end