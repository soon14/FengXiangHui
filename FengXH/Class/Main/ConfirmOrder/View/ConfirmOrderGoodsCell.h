//
//  ConfirmOrderGoodsCell.h
//  FengXH
//
//  Created by sun on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConfirmOrderCreatResultGoodsListGoodsModel;

@interface ConfirmOrderGoodsCell : UITableViewCell

/** 商品 Model */
@property(nonatomic , strong)ConfirmOrderCreatResultGoodsListGoodsModel *goodsListModel;

@end
