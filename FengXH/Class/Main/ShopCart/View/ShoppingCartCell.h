//
//  ShoppingCartCell.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditCountView.h"
#import "ShoppingCartModel.h"

typedef void (^CartCellButtonClickBlock)(ShoppingCartGoodsModel *goodsModel);

@interface ShoppingCartCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic , strong)UIButton *selectButton;
@property(nonatomic , strong)UIImageView *goodsImageV;
@property(nonatomic , strong)UILabel *goodsNameLabel;
@property(nonatomic , strong)UILabel *priceLabel;
@property(nonatomic , strong)EditCountView *editCountView;

@property(nonatomic , strong)ShoppingCartGoodsModel *cartGoodsModel;

@property(nonatomic , strong)CartCellButtonClickBlock selectClickBlock;
@property(nonatomic , strong)CartCellButtonClickBlock minsBtnClickBlock;
@property(nonatomic , strong)CartCellButtonClickBlock plusBtnClickBlock;

@end
