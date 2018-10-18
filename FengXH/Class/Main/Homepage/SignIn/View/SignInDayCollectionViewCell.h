//
//  SigninDayCollectionViewCell.h
//  SignIn_demo
//
//  Created by sun on 2018/9/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SignInDayBlock)(NSString *dateString);

@interface SignInDayCollectionViewCell : UICollectionViewCell

/** 日期 */
@property(nonatomic , copy)NSString *dateString;
/** 签到的日期数组 */
@property(nonatomic , strong)NSArray *signedArray;
/** block */
@property(nonatomic , strong)SignInDayBlock signInDayBlock;

@end
