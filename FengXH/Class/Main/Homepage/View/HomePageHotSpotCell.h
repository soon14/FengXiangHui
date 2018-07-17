//
//  HomePageHotSpotCell.h
//  FengXH
//
//  Created by 孙湖滨 on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomepageDataNoticeDataModel;

@interface HomePageHotSpotCell : UICollectionViewCell
/** 数据模型 */
@property(nonatomic , strong)HomepageDataNoticeDataModel *noticeDataModel;
@end
