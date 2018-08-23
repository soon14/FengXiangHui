//
//  StoreSettionThirdTableViewCell.h
//  FengXH
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^StoreSettionThirdTableViewCellBlock)(void);

@interface StoreSettionThirdTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton *imgBtn;

@property(nonatomic,copy)StoreSettionThirdTableViewCellBlock upLoadClick;

@end
