//
//  SignInHeaderCollectionReusableView.h
//  FengXH
//
//  Created by sun on 2018/10/9.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SignInHeaderBlcok)(NSInteger index);

@class SignInResultModel;
@interface SignInHeaderCollectionReusableView : UICollectionReusableView

/** model */
@property(nonatomic , strong)SignInResultModel *headerResultModel;
/** block */
@property(nonatomic , strong)SignInHeaderBlcok signInHeaderBlock;

@end

NS_ASSUME_NONNULL_END
