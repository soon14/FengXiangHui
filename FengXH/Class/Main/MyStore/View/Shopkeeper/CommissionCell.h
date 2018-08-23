//
//  CommissionCell.h
//  FengXH
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommissionCell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UILabel *priceLab;

@property(nonatomic,strong)NSDictionary *commissionData;

@end
