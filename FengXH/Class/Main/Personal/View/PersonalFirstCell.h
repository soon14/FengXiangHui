//
//  PersonalFirstCell.h
//  FengXH
//
//  Created by sun on 2018/7/12.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PersonalFirstCellBlock)(NSInteger index);

@interface PersonalFirstCell : UITableViewCell

/** setting */
@property(nonatomic , strong)UIButton *settingButton;
/** userIcon */
@property(nonatomic , strong)UIImageView *userIcon;
/** userName */
@property(nonatomic , strong)UILabel *userNameLabel;
/** userType */
@property(nonatomic , strong)UILabel *userTypeLabel;
/** Invitation code */
@property(nonatomic , strong)UILabel *invitationCodeLabel;
/** F 币 */
@property(nonatomic , strong)UILabel *coinLabel;
/** 积分 */
@property(nonatomic , strong)UILabel *integralLabel;
/** 充值 */
@property(nonatomic , strong)UIButton *rechargeButton;
/** 兑换 */
@property(nonatomic , strong)UIButton *exchangeButton;
/** block */
@property(nonatomic , strong)PersonalFirstCellBlock cellClickBlock;

@end
