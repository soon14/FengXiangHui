//
//  IntegralMallResutlModel.h
//  FengXH
//
//  Created by  on 2018/9/27.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralMallResultModel : NSObject

/** items */
@property(nonatomic , strong)NSArray *items;

@end



@interface IntegralMallResultItemsModel : NSObject

/** id */
@property(nonatomic , copy)NSString *itemsID;
/** items */
@property(nonatomic , strong)NSArray *items;

@end

@interface IntegralMallResultItemsGoodsModel : NSObject

/** 图片 */
@property(nonatomic , copy)NSString *thumb;
/** 商品名 */
@property(nonatomic , copy)NSString *title;
/** subtitle */
@property(nonatomic , copy)NSString *subtitle;
/** 所需价格 */
@property(nonatomic , copy)NSString *price;
/** 商品 id */
@property(nonatomic , copy)NSString *gid;
/** 库存 */
@property(nonatomic , copy)NSString *total;
/** 所需积分 */
@property(nonatomic , assign)NSInteger credit;
/** type */
@property(nonatomic , copy)NSString *type;

@end

NS_ASSUME_NONNULL_END
