//
//  CartCellHeaderView.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonClickBlock)(NSString *selectIdsString, BOOL selected);

@interface CartCellHeaderView : UITableViewHeaderFooterView

@property(nonatomic , strong)UIButton *selectButton;
@property(nonatomic , strong)UILabel *storeNameLabel;

/** section */
@property(nonatomic , assign)NSInteger section;
@property(nonatomic , strong)NSArray *storeArray;

@property(nonatomic , strong)ButtonClickBlock clickBlock;

@end
