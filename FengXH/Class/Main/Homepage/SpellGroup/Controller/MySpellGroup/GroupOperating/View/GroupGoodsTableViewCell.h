//
//  GroupGoodsTableViewCell.h
//  FengXH
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GroupOperatingModel;
@interface GroupGoodsTableViewCell : UITableViewCell
@property (nonatomic ,strong) GroupOperatingModel *groupOperatingModel;
@property (nonatomic ,copy) NSString *type;
@end
