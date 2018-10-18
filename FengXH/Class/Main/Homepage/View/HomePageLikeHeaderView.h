//
//  HomepageLikeHeaderView.h
//  FengXH
//
//  Created by sun on 2018/10/11.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HomepageResultPictureModel;
@interface HomePageLikeHeaderView : UICollectionReusableView

/** model */
@property(nonatomic , strong)HomepageResultPictureModel *pictureModel;

@end

NS_ASSUME_NONNULL_END
