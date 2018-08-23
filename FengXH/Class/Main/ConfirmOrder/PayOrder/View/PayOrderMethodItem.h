//
//  PayOrderMethodItem.h
//  FengXH
//
//  Created by sun on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayOrderMethodItem : UIView

/** imageView */
@property(nonatomic , strong)UIImageView *iconView;
/** title */
@property(nonatomic , strong)UILabel *titleLabel;
/** detail */
@property(nonatomic , strong)UILabel *detailLabel;

@end
