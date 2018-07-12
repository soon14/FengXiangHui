//
//  HomepageFifthCell.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepageDataModel.h"
typedef void (^FifthCellBlock)(NSInteger index);

@interface HomepageFifthCell : UICollectionViewCell

/** 数据模型 */
@property(nonatomic , strong)HomepageDataHotPictureModel *picturewModel;
/** block */
@property(nonatomic , strong)FifthCellBlock fifthCellBlock;
/** leftItem */
@property(nonatomic , strong)UIImageView *leftItem;
/** middleItem */
@property(nonatomic , strong)UIImageView *middleItem;
/** rightItem */
@property(nonatomic , strong)UIImageView *rightItem;

@end
