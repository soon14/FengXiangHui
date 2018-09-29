//
//  GoodsDetailGoodsInfoCell.h
//  FengXH
//
//  Created by sun on 2018/9/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailResultModel,GoodsDetailGoodsInfoCell;

@protocol GoodsDetailGoodsInfoCellDelegate <NSObject>
- (void)GoodsDetailGoodsInfoCell:(GoodsDetailGoodsInfoCell *)cell shareAction:(UIButton *)sender;
@end

@interface GoodsDetailGoodsInfoCell : UITableViewCell

/** model */
@property(nonatomic , strong)GoodsDetailResultModel *goodsDetailResultModel;
/** delegate */
@property(nonatomic , weak)id <GoodsDetailGoodsInfoCellDelegate> delegate;

@end
