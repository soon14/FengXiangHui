//
//  IntegralRecordCell.h
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IntegralRecordResultListModel;

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRecordCell : UITableViewCell

/** model */
@property(nonatomic , strong)IntegralRecordResultListModel *recordListModel;

@end

NS_ASSUME_NONNULL_END
