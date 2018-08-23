//
//  MyFocusCell.h
//  FengXH
//
//  Created by sun on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyFocusResultListModel;

@interface MyFocusCell : UITableViewCell

/** model */
@property(nonatomic , strong)MyFocusResultListModel *focusResultListModel;
/** editing */
@property(nonatomic , assign)BOOL editingStatus;

@end
