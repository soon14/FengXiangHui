//
//  IntegralRecordBaseHeaderView.h
//  FengXH
//
//  Created by sun on 2018/9/26.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^IntegralRecordBaseHeaderViewBlock)(NSInteger index);

@interface IntegralRecordBaseHeaderView : UIView

/** 全部记录 */
@property(nonatomic , strong)UIButton *allRecordButton;
/** 兑换记录 */
@property(nonatomic , strong)UIButton *exchangeButton;
/** 中奖记录 */
@property(nonatomic , strong)UIButton *winnerButton;
/** 移动光标 */
@property(nonatomic , strong)UIView *moveLine;
/** block */
@property(nonatomic , strong)IntegralRecordBaseHeaderViewBlock headerBlock;

@end

NS_ASSUME_NONNULL_END
