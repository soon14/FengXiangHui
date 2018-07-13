//
//  PersonalSecondCell.h
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCellItem.h"
typedef void (^PersonalSecondCellBlock)(NSInteger index);

@interface PersonalSecondCell : UITableViewCell

/** block */
@property(nonatomic , strong)PersonalSecondCellBlock cellClickBlock;

@end
