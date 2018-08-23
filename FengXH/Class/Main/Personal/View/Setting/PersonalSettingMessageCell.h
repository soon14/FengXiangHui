//
//  PersonalSettingMessageCell.h
//  FengXH
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalSettingMessageCell : UITableViewCell
//标题
@property(nonatomic,strong)UILabel *titleLab;
//输入框
@property(nonatomic,strong)UITextField *contentTextField;
//data
@property(nonatomic,strong)NSDictionary *dataDic;
@end
