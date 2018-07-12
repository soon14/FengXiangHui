//
//  ShoppingCartModel.h
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartModel : NSObject

@property(nonatomic , strong)NSMutableArray *info;

@end



//
@interface ShoppingCartStoreModel : NSObject

#pragma mark - 记录商品被选中的状态
@property(nonatomic , assign)BOOL storeSelected;

@property(nonatomic , strong)NSMutableArray *goods;
@property(nonatomic , strong)NSString *store_id;
@property(nonatomic , strong)NSString *store_name;

@end



@interface ShoppingCartGoodsModel : NSObject

#pragma mark - 记录商品被选中的状态
@property(nonatomic , assign)BOOL goodsSelected;

@property(nonatomic , strong)NSString *goods_name;
@property(nonatomic , strong)NSString *goods_price;
@property(nonatomic , assign)NSInteger goods_num;//商品数量

@end
