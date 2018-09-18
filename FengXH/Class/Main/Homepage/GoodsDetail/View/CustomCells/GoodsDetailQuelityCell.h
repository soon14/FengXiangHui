//
//  GoodsDetailQuelityCell.h
//  FengXH
//
//  Created by 孙湖滨 on 2018/9/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailQuelityItemCell;

@interface GoodsDetailQuelityCell : UITableViewCell

/** 质量保证数组 */
@property(nonatomic , strong)NSArray *qualityArray;

@end



@interface GoodsDetailQuelityItemCell : UICollectionViewCell

/** 保证信息 */
@property(nonatomic , copy)NSString *quality;

@end
