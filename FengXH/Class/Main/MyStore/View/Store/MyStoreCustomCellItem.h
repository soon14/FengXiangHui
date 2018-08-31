//
//  MyStoreCustomCellItem.h
//  FengXH
//
//  Created by sun on 2018/8/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStoreCustomCellItem : UIView

/** icon */
@property(nonatomic , strong)UIImageView *icon;
/** title */
@property(nonatomic , strong)UILabel *titleLabel;
/** detail */
@property(nonatomic , strong)UILabel *detailLabel;

@end
