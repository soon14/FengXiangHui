//
//  AccountView.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AccountViewBlock)(NSInteger index);

@interface AccountView : UIView

/** 全选按钮 */
@property(nonatomic , strong)UIButton *allSelectButton;
/** 结算按钮 */
@property(nonatomic , strong)UIButton *accountButton;
/** 合计价格 */
@property(nonatomic , strong)UILabel *totalPriceLabel;
/** 运费价格 */
@property(nonatomic , strong)UILabel *freightLabel;
/** 删除 */
@property(nonatomic , strong)UIButton *deleteButton;
/** 移入关注 */
@property(nonatomic , strong)UIButton *collectButton;

@property(nonatomic , strong)AccountViewBlock accountViewBlock;

@end
