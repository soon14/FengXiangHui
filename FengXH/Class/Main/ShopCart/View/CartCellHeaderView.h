//
//  CartCellHeaderView.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"

typedef void (^ButtonClickBlock)(ShoppingCartStoreModel *storeModel);

@interface CartCellHeaderView : UIView

@property(nonatomic , strong)UIButton *selectButton;
@property(nonatomic , strong)UILabel *storeNameLabel;

@property(nonatomic , strong)ShoppingCartStoreModel *storeModel;

@property(nonatomic , strong)ButtonClickBlock clickBlock;

@end
