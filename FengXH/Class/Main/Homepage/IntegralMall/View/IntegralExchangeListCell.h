//
//  IntegralExchangeListCell.h
//  FengXH
//
//  Created by  on 2018/9/27.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IntegralExchangeResultListModel;

NS_ASSUME_NONNULL_BEGIN

@interface IntegralExchangeListCell : UITableViewCell

/** model */
@property(nonatomic , strong)IntegralExchangeResultListModel *exchangeListModel;

@end

NS_ASSUME_NONNULL_END
