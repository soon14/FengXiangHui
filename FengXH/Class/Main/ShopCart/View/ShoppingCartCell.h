//
//  ShoppingCartCell.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditCountView.h"
@class ShoppingCartResultListModel;

/** 商品数量改变的 block */
typedef void (^CartCellGoodsNumberBlock)(ShoppingCartResultListModel *goodsModel, NSInteger goodsNumber);
/** 商品被选择的 block */
typedef void (^CartCellGoodsSelectBlock)(NSString *selectIdsString, BOOL selected);
/** 友情提示 block */
typedef void (^CartCellAlertBlock)(NSString *message);

@interface ShoppingCartCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic , strong)UIButton *selectButton;
@property(nonatomic , strong)UIImageView *goodsImageV;
@property(nonatomic , strong)UILabel *goodsNameLabel;
@property(nonatomic , strong)UILabel *priceLabel;
@property(nonatomic , strong)EditCountView *editCountView;

/** indexPath 用于刷新 */
//@property(nonatomic , strong)NSIndexPath *indexPath;
@property(nonatomic , strong)ShoppingCartResultListModel *cartGoodsModel;

/** block */
@property(nonatomic , strong)CartCellGoodsSelectBlock selectClickBlock;

@property(nonatomic , strong)CartCellGoodsNumberBlock minsBtnClickBlock;
@property(nonatomic , strong)CartCellGoodsNumberBlock plusBtnClickBlock;
@property(nonatomic , strong)CartCellGoodsNumberBlock endEditNumberBlock;

/** alertBlock */
@property(nonatomic , strong)CartCellAlertBlock alertBlock;

@end
