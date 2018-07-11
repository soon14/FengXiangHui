//
//  HomepageFourthCell.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageDataModel.h"

@interface HomepageFourthCell : UICollectionViewCell

/** hotImageView */
@property(nonatomic , strong)UIImageView *hotImageView;
/** 数据模型 */
@property(nonatomic , strong)HomepageDataNoticeDataModel *noticeDataModel;

@end
