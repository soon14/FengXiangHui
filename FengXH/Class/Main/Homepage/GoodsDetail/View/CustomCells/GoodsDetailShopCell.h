//
//  GoodsDetailShopCell.h
//  FengXH
//
//  Created by sun on 2018/9/17.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailResultShopdetailModel,GoodsDetailShopCell;

@protocol GoodsDetailShopCellDelegate <NSObject>
- (void)GoodsDetailShopCell:(GoodsDetailShopCell *)cell buttonAction:(UIButton *)sender;
@end

@interface GoodsDetailShopCell : UITableViewCell

/** mdoel */
@property(nonatomic , strong)GoodsDetailResultShopdetailModel *shopDetailModel;
/** delegate */
@property(nonatomic , strong)id delegate;

@end
