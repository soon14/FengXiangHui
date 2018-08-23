//
//  StoreSettionSecondTableViewCell.h
//  FengXH
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^StoreSettionSecondTableViewCellBlock)(void);

@interface StoreSettionSecondTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton *iconBtn;

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,copy)StoreSettionSecondTableViewCellBlock addClick;

@end
