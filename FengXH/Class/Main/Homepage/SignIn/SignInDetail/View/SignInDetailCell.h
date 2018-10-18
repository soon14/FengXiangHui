//
//  SignInDetailCell.h
//  FengXH
//
//  Created by sun on 2018/10/8.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SignInDetailResultListModel;

@interface SignInDetailCell : UITableViewCell

/** model */
@property(nonatomic , strong)SignInDetailResultListModel *signInDetailModel;

@end

NS_ASSUME_NONNULL_END
