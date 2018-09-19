//
//  GoodsDetailFreightCell.h
//  FengXH
//
//  Created by sun on 2018/9/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailResultJDGoodsModel;

@interface GoodsDetailFreightCell : UITableViewCell

/** 运费 */
@property(nonatomic , copy)NSString *freight;
/** model */
@property(nonatomic , strong)GoodsDetailResultJDGoodsModel *jdGoodsModel;

@end
