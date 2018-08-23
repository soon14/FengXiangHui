//
//  ConfirmOrderStoreHeaderView.h
//  FengXH
//
//  Created by sun on 2018/8/3.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConfirmOrderCreatResultGoodsListModel;

@interface ConfirmOrderStoreHeaderView : UITableViewHeaderFooterView

/** 商城信息 Model */
@property(nonatomic , strong)ConfirmOrderCreatResultGoodsListModel *storeModel;

@end
