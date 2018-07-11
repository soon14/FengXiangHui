//
//  HomepageDataModel.h
//  FengXH
//
//  Created by 孙湖滨 on 2018/7/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomepageDataBannerModel,HomepageDataMenuFirstModel,HomepageDataMenuSecondModel,HomepageDataNoticeModel,HomepageDataNoticeDataModel;

@interface HomepageDataModel : NSObject

/** 滚动广告 */
@property(nonatomic , strong)HomepageDataBannerModel *M1471835880921;
/** 10个专区-1 */
@property(nonatomic , strong)HomepageDataMenuFirstModel *M1471835886075;
/** 10个专区-2 */
@property(nonatomic , strong)HomepageDataMenuSecondModel *M1529474107640;
/** 热点 */
@property(nonatomic , strong)HomepageDataNoticeModel *M1482809676486;

@end


#pragma mark - 滚动广告
@interface HomepageDataBannerModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end


#pragma mark - 滚动广告data
@interface HomepageDataBannerDataModel : NSObject

/** imgurl */
@property(nonatomic , copy)NSString *imgurl;
/** linkurl */
@property(nonatomic , copy)NSString *linkurl;

@end


#pragma mark - 10个专区-1
@interface HomepageDataMenuFirstModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end

#pragma mark - 10个专区-1
@interface HomepageDataMenuSecondModel : NSObject

/** data */
@property(nonatomic , strong)NSArray *data;

@end

#pragma mark - 10个专区data
@interface HomepageDataMenuDataModel : NSObject

/** imgurl */
@property(nonatomic , copy)NSString *imgurl;
/** linkurl */
@property(nonatomic , copy)NSString *linkurl;
/** text */
@property(nonatomic , copy)NSString *text;

@end


#pragma mark - 热点
@interface HomepageDataNoticeModel : NSObject

/** data */
@property(nonatomic , strong)HomepageDataNoticeDataModel *data;

@end

@interface HomepageDataNoticeDataModel : NSObject

/** iconurl */
@property(nonatomic , copy)NSString *iconurl;
/** data */
@property(nonatomic , strong)NSArray *data;

@end

@interface HomepageDataNoticeDataDetailsModel : NSObject

/** iconurl */
@property(nonatomic , copy)NSString *title;
/** linkurl */
@property(nonatomic , copy)NSString *linkurl;

@end





