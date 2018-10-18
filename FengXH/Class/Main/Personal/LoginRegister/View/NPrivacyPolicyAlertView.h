//
//  NPrivacyPolicyAlertView.h
//  FengXH
//
//  Created by sun on 2018/10/16.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NPrivacyPolicyAlertViewBlock)(NSInteger index);

@interface NPrivacyPolicyAlertView : UIView

/** block */
@property(nonatomic , strong)NPrivacyPolicyAlertViewBlock agreePolicyBlock;

@end


@interface NPrivacyPolicyAlertCell : UITableViewCell

/** content */
@property(nonatomic , copy)NSString *contentString;

@end

NS_ASSUME_NONNULL_END
