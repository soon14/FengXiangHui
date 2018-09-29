//
//  IntegralRecordDetailStatusCell.h
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IntegralRecordDetailResultModel;

NS_ASSUME_NONNULL_BEGIN

@interface IntegralRecordDetailStatusCell : UITableViewCell

/** model */
@property(nonatomic , strong)IntegralRecordDetailResultModel *statusModel;

@end

NS_ASSUME_NONNULL_END
