//
//  HomePageHotSpotCell.h
//  FengXH
//
//  Created by sun on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomepageResultNoticeModel;

@interface HomePageHotSpotCell : UICollectionViewCell
/** 数据模型 */
@property(nonatomic , strong)HomepageResultNoticeModel *noticeDataModel;
@end
