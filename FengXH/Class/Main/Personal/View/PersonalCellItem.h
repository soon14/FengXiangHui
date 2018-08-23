//
//  PersonalCellItem.h
//  FengXH
//
//  Created by sun on 2018/7/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCellItem : UIView

/** image */
@property(nonatomic , strong)UIImageView *itemImageView;
/** title */
@property(nonatomic , strong)UILabel *itemTitleLabel;
/** Badge */
@property(nonatomic , strong)UILabel *badgeLabel;

@end
