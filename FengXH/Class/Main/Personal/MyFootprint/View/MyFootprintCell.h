//
//  MyFootprintCell.h
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyFootprintResultListModel;

@interface MyFootprintCell : UITableViewCell

/** model */
@property(nonatomic , strong)MyFootprintResultListModel *footprintModel;
/** editing */
@property(nonatomic , assign)BOOL editingStatus;

@end
