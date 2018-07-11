//
//  HomepageSixthCell.h
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageDataModel.h"

typedef void (^HomeSixthCellBlock)(NSInteger index);
@interface HomepageSixthCell : UICollectionViewCell

/** 倒计时图片 */
@property(nonatomic , strong)UIImageView *timeImageView;
/** 倒计时 */
@property(nonatomic , strong)UILabel *countDownLabel;
/** 更多按钮 */
@property(nonatomic , strong)UIButton *moreButton;
/** block */
@property(nonatomic , strong)HomeSixthCellBlock sixthCellBlock;
/** 数据模型 */
@property(nonatomic , strong)HomepageDataSecondKillModel *secondKillModel;

@end
