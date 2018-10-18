//
//  SignInCanDrawCollectionViewCell.h
//  FengXH
//
//  Created by sun on 2018/10/10.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SignInRewordBlock)(NSString *dayString);

@interface SignInCanDrawCollectionViewCell : UICollectionViewCell

/** 连续签到可领取积分的数组 */
@property(nonatomic , strong)NSArray *canDrawArray;
/**  领取按钮block */
@property(nonatomic , strong)SignInRewordBlock rewordBlock;

@end

@class SignInResultAdvawardOrderModel,SignInCanDrawOrderCollectionViewCell;

@protocol SignInCanDrawOrderCollectionViewCellDelegate <NSObject>
- (void)SignInCanDrawOrderCollectionViewCell:(SignInCanDrawOrderCollectionViewCell *)cell signInDrawWith:(SignInResultAdvawardOrderModel *)orderModel;
@end

@interface SignInCanDrawOrderCollectionViewCell : UICollectionViewCell

/** 连续签到可领取积分的数组 */
@property(nonatomic , strong)SignInResultAdvawardOrderModel *canDrawOrderModel;
/** 代理 */
@property(nonatomic , weak)id <SignInCanDrawOrderCollectionViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
