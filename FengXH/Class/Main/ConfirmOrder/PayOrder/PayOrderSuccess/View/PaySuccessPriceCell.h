//
//  PaySuccessPriceCell.h
//  FengXH
//
//  Created by sun on 2018/8/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PaySuccessResultDataModel;

@interface PaySuccessPriceCell : UITableViewCell

/** pay */
@property(nonatomic , strong)PaySuccessResultDataModel *successDataModel;

@end
