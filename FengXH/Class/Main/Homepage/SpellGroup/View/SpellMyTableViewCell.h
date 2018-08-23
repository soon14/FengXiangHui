//
//  SpellMyTableViewCell.h
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyGroupModel;
@protocol SpellMyCellDelegate <NSObject>
- (void)onItemClick:(UIButton *)btn;
@end
@interface SpellMyTableViewCell : UITableViewCell
/** 数据模型 */
@property (nonatomic ,strong) MyGroupModel *myGroupModel;
@property(nonatomic , weak)id <SpellMyCellDelegate> delegate;
- (void)setType:(NSInteger)type;
@end
