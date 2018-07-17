//
//  HomePagePicturewCell.h
//  FengXH
//
//  Created by sun on 2018/7/16.
//  Copyright © 2018年 HubinSun. All rights reserved.
//
//  店主礼包、京东优选、店主专区等，专门用来存放纯图片的cell


#import <UIKit/UIKit.h>
@class HomepageDataHotPictureModel,HomepageDataMenuDataModel,HomepageDataFirstCategoryImageModel,HomePagePicturewCell;

@protocol HomePagePicturewDelegate <NSObject>
/**
 点击了图片需要跳转功能
 
 @param cell cell
 @param functionItemModel 图片模型
 */
- (void)HomePagePicturewCell:(HomePagePicturewCell *)cell didSelectPicturerwItemWith:(HomepageDataMenuDataModel *)functionItemModel;
@end

@interface HomePagePicturewCell : UICollectionViewCell

/** 图片 */
@property(nonatomic , strong)NSArray *pictureArray ;
/** 代理 */
@property(nonatomic , weak)id <HomePagePicturewDelegate> delegate;

@end


@interface HomePagePicturewImageCell : UICollectionViewCell
/** 模型 */
@property(nonatomic , strong)HomepageDataMenuDataModel * pictureModel ;
@end
