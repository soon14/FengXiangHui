//
//  PersonalFourthCell.h
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCellItem.h"
typedef void (^PersonalThirdCellBlock)(NSInteger index);

@interface PersonalFourthCell : UITableViewCell

/** block */
@property(nonatomic , strong)PersonalThirdCellBlock cellClickBlock;

@end
